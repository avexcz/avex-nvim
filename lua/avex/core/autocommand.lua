-- AUTO INSTALL — Tree-sitter parsers + system tools
-- Supports macOS (Homebrew), Linux (apt/dnf/pacman), Windows (winget/choco/scoop)

local M = {}


-- ── PLATFORM DETECTION ────────────────────────────────────────────────────────

local uname = (vim.uv or vim.loop).os_uname()
local sysname = uname.sysname:lower()

local is_mac     = sysname:find("darwin")  ~= nil
local is_linux   = sysname:find("linux")   ~= nil
local is_windows = sysname:find("windows") ~= nil or vim.fn.has("win32") == 1


-- ── WHITELISTED FILETYPES ─────────────────────────────────────────────────────

local real_filetypes = {
    lua = true, python = true, javascript = true, typescript = true,
    html = true, css = true, json = true, bash = true, sh = true,
    rust = true, c = true, cpp = true, go = true, yaml = true,
    toml = true, dockerfile = true, vim = true, markdown = true,
}


-- ── LINUX PACKAGE MANAGER DETECTION ──────────────────────────────────────────

-- Returns the first available package manager and its install verb.
local function detect_linux_pm()
    local candidates = {
        { bin = "apt-get", cmd = { "sudo", "apt-get", "install", "-y" } },
        { bin = "dnf",     cmd = { "sudo", "dnf",     "install", "-y" } },
        { bin = "pacman",  cmd = { "sudo", "pacman",  "-S", "--noconfirm" } },
        { bin = "zypper",  cmd = { "sudo", "zypper",  "install", "-y" } },
    }
    for _, pm in ipairs(candidates) do
        if vim.fn.executable(pm.bin) == 1 then
            return pm.cmd
        end
    end
    return nil
end

-- Package name overrides per Linux PM (binary → {apt, dnf, pacman, zypper})
local linux_pkg_names = {
    rg   = { "ripgrep", "ripgrep",  "ripgrep",  "ripgrep" },
    fd   = { "fd-find", "fd-find",  "fd",       "fd" },
    node = { "nodejs",  "nodejs",   "nodejs",   "nodejs" },
}

local linux_pm_index = {
    ["apt-get"] = 1,
    ["dnf"]     = 2,
    ["pacman"]  = 3,
    ["zypper"]  = 4,
}


-- ── WINDOWS PACKAGE MANAGER DETECTION ────────────────────────────────────────

local function detect_windows_pm()
    local candidates = {
        { bin = "winget", cmd = { "winget", "install", "--silent", "--accept-package-agreements" } },
        { bin = "choco",  cmd = { "choco",  "install", "-y" } },
        { bin = "scoop",  cmd = { "scoop",  "install" } },
    }
    for _, pm in ipairs(candidates) do
        if vim.fn.executable(pm.bin) == 1 then
            return pm.cmd
        end
    end
    return nil
end

local windows_pkg_names = {
    rg   = { winget = "BurntSushi.ripgrep.MSVC", choco = "ripgrep",  scoop = "ripgrep" },
    fd   = { winget = "sharkdp.fd",               choco = "fd",       scoop = "fd" },
    node = { winget = "OpenJS.NodeJS.LTS",         choco = "nodejs",   scoop = "nodejs" },
}

local function resolve_windows_pkg(tool, pm_cmd)
    local pm_bin = pm_cmd[1]
    local overrides = windows_pkg_names[tool]
    if overrides and overrides[pm_bin] then
        return overrides[pm_bin]
    end
    return tool
end


-- ── GENERIC ASYNC INSTALL ─────────────────────────────────────────────────────

local function run_install(label, cmd)
    vim.notify("Installing " .. label .. "…", vim.log.levels.INFO)
    vim.fn.jobstart(cmd, {
        on_exit = function(_, code)
            if code == 0 then
                vim.notify(label .. " installed successfully!", vim.log.levels.INFO)
            else
                vim.notify(
                    "Failed to install " .. label .. ". Please install it manually.",
                    vim.log.levels.ERROR
                )
            end
        end,
    })
end


-- ── PLATFORM-AWARE TOOL INSTALLER ────────────────────────────────────────────

-- `tool`     — executable name to check
-- `pkg`      — optional override package name (used only for brew/npm)
-- `npm_pkg`  — if set, install via npm instead of system PM
local function ensure_tool(tool, pkg, npm_pkg)
    if vim.fn.executable(tool) == 1 then return end

    if npm_pkg then
        -- npm path is the same everywhere
        if vim.fn.executable("npm") == 0 then
            vim.notify("npm not found — install Node.js first.", vim.log.levels.WARN)
            return
        end
        run_install(tool, { "npm", "install", "-g", npm_pkg })
        return
    end

    if is_mac then
        if vim.fn.executable("brew") == 0 then
            vim.notify("Homebrew not found. Install from https://brew.sh", vim.log.levels.WARN)
            return
        end
        run_install(tool, { "brew", "install", pkg or tool })

    elseif is_linux then
        local pm_cmd = detect_linux_pm()
        if not pm_cmd then
            vim.notify("No supported package manager found (apt/dnf/pacman/zypper).", vim.log.levels.WARN)
            return
        end
        local pm_bin = pm_cmd[2] or pm_cmd[1]
        local idx    = linux_pm_index[pm_bin] or 1
        local names  = linux_pkg_names[tool]
        local resolved = (names and names[idx]) or pkg or tool
        run_install(tool, vim.list_extend(vim.deepcopy(pm_cmd), { resolved }))

    elseif is_windows then
        local pm_cmd = detect_windows_pm()
        if not pm_cmd then
            vim.notify("No supported package manager found (winget/choco/scoop).", vim.log.levels.WARN)
            return
        end
        local resolved = resolve_windows_pkg(tool, pm_cmd)
        run_install(tool, vim.list_extend(vim.deepcopy(pm_cmd), { resolved }))

    else
        vim.notify("Unsupported platform — install " .. tool .. " manually.", vim.log.levels.WARN)
    end
end


-- ── ENSURE NEOVIM NPM PACKAGE (one-time flag) ────────────────────────────────

local function ensure_neovim_npm()
    local flag = vim.fn.stdpath("data") .. "/.neovim_npm_installed"
    if vim.fn.filereadable(flag) == 1 then return end
    if vim.fn.executable("npm") == 0 then return end

    vim.notify("Installing neovim npm package…", vim.log.levels.INFO)
    vim.fn.jobstart({ "npm", "install", "-g", "neovim" }, {
        on_exit = function(_, code)
            if code == 0 then
                vim.fn.writefile({}, flag)
                vim.notify("neovim npm package installed!", vim.log.levels.INFO)
            end
        end,
    })
end


-- ── CHECK AND INSTALL ALL SYSTEM TOOLS ───────────────────────────────────────

local function check_system_tools()
    ensure_tool("rg",   "ripgrep")
    ensure_tool("fd",   "fd")
    ensure_tool("node", "node")
    -- tree-sitter CLI is best installed via npm on all platforms
    ensure_tool("tree-sitter", nil, "tree-sitter-cli")
    ensure_neovim_npm()
end


-- ── TREE-SITTER PARSERS ───────────────────────────────────────────────────────

local parsers = {
    "lua", "python", "javascript", "typescript",
    "html", "css", "json", "bash", "rust",
    "c", "cpp", "go", "yaml", "toml",
    "dockerfile", "vim", "vimdoc", "query",
    "markdown", "markdown_inline",
}

local function install_treesitter_parsers()
    local info_ok, ts_info = pcall(require, "nvim-treesitter.info")
    if not info_ok then return end

    local installed     = ts_info.installed_parsers()
    local installed_set = {}
    for _, p in ipairs(installed) do installed_set[p] = true end

    local missing = {}
    for _, parser in ipairs(parsers) do
        if not installed_set[parser] then
            table.insert(missing, parser)
        end
    end

    if #missing == 0 then return end

    vim.notify(
        "Installing " .. #missing .. " Tree-sitter parser(s): " .. table.concat(missing, ", "),
        vim.log.levels.INFO
    )
    vim.cmd("TSInstall " .. table.concat(missing, " "))
end


-- ── AUTOCOMMANDS ─────────────────────────────────────────────────────────────

local group = vim.api.nvim_create_augroup("avex_autoinstall", { clear = true })

-- Run once on startup
vim.api.nvim_create_autocmd("VimEnter", {
    group    = group,
    once     = true,
    callback = function()
        check_system_tools()
        install_treesitter_parsers()
    end,
})

-- Auto-install parser when opening a whitelisted filetype for the first time
vim.api.nvim_create_autocmd("FileType", {
    group    = group,
    callback = function()
        local ft = vim.bo.filetype
        if ft == "" or not real_filetypes[ft] then return end

        local lang_ok, lang = pcall(vim.treesitter.language.get_lang, ft)
        if not lang_ok or not lang then return end

        local parser_ok = pcall(vim.treesitter.language.inspect, lang)
        if not parser_ok then
            vim.notify("Installing Tree-sitter parser: " .. lang, vim.log.levels.INFO)
            vim.cmd("TSInstall " .. lang)
        end
    end,
})

return M
