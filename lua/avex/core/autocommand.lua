-- AUTO INSTALL — Tree-sitter parsers + system tools

local M = {}

-- ── WHITELISTED FILETYPES ─────────────────────────────────────────────────────
local real_filetypes = {
    lua = true, python = true, javascript = true, typescript = true,
    html = true, css = true, json = true, bash = true, sh = true,
    rust = true, c = true, cpp = true, go = true, yaml = true,
    toml = true, dockerfile = true, vim = true, markdown = true,
}

-- ── INSTALL VIA HOMEBREW ──────────────────────────────────────────────────────
local function brew_install(tool, brew_name)
    if vim.fn.executable(tool) == 1 then return end

    vim.notify("Installing " .. tool .. " via Homebrew...", vim.log.levels.INFO)

    vim.fn.jobstart({ "brew", "install", brew_name or tool }, {
        on_exit = function(_, code)
            if code == 0 then
                vim.notify(tool .. " installed successfully!", vim.log.levels.INFO)
            else
                vim.notify(
                    "Failed to install " .. tool .. ". Install manually: brew install " .. (brew_name or tool),
                    vim.log.levels.ERROR
                )
            end
        end,
    })
end

-- ── INSTALL VIA NPM ───────────────────────────────────────────────────────────
local function npm_install(tool, pkg_name)
    if vim.fn.executable(tool) == 1 then return end

    if vim.fn.executable("npm") == 0 then
        vim.notify(
            "npm not found. Install Node.js first: brew install node",
            vim.log.levels.ERROR
        )
        return
    end

    vim.notify("Installing " .. tool .. " via npm...", vim.log.levels.INFO)

    vim.fn.jobstart({ "npm", "install", "-g", pkg_name or tool }, {
        on_exit = function(_, code)
            if code == 0 then
                vim.notify(tool .. " installed successfully!", vim.log.levels.INFO)
            else
                vim.notify(
                    "Failed to install " .. tool .. ". Install manually: npm install -g " .. (pkg_name or tool),
                    vim.log.levels.ERROR
                )
            end
        end,
    })
end

-- ── INSTALL NEOVIM VIA NPM ───────────────────────────────────────
local function ensure_neovim_npm()
    local flag = vim.fn.stdpath("data") .. "/.neovim_npm_installed"

    -- if flag file exists, already installed, skip
    if vim.fn.filereadable(flag) == 1 then return end

    if vim.fn.executable("npm") == 0 then return end

    vim.notify("Installing neovim npm package...", vim.log.levels.INFO)

    vim.fn.jobstart({ "npm", "install", "-g", "neovim" }, {
        on_exit = function(_, code)
            if code == 0 then
                vim.fn.writefile({}, flag)
                vim.notify("neovim npm installed successfully!", vim.log.levels.INFO)
            end
        end,
    })
end


-- ── CHECK AND INSTALL ALL SYSTEM TOOLS ───────────────────────────────────────
local function check_system_tools()
    brew_install("rg",   "ripgrep")
    brew_install("fd",   "fd")
    brew_install("node", "node")
    npm_install("tree-sitter", "tree-sitter-cli")

       local ok = vim.fn.system("npm list -g neovim 2>/dev/null | grep neovim")
    if ok == "" then
        npm_install_silent("neovim", "neovim")
    end
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

    local installed = ts_info.installed_parsers()
    local installed_set = {}
    for _, p in ipairs(installed) do
        installed_set[p] = true
    end

    local to_install = {}
    for _, parser in ipairs(parsers) do
        if not installed_set[parser] then
            table.insert(to_install, parser)
        end
    end

    if #to_install == 0 then return end

    vim.notify(
        "Installing " .. #to_install .. " Tree-sitter parsers: " .. table.concat(to_install, ", "),
        vim.log.levels.INFO
    )

    vim.cmd("TSInstall " .. table.concat(to_install, " "))
end

-- ── AUTOCOMMANDS (group must be defined before any autocmd uses it) ───────────
local group = vim.api.nvim_create_augroup("avex_autoinstall", { clear = true })

-- run once on startup
vim.api.nvim_create_autocmd("VimEnter", {
    group    = group,
    once     = true,
    callback = function()
        check_system_tools()
        ensure_neovim_npm()
        install_treesitter_parsers()
    end,
})

-- auto install parser for real filetypes only
vim.api.nvim_create_autocmd("FileType", {
    group    = group,
    callback = function()
        local ft = vim.bo.filetype
        if ft == "" then return end
        if not real_filetypes[ft] then return end  -- blocks notify, noice, NvimTree etc.

        local lang_ok, lang = pcall(vim.treesitter.language.get_lang, ft)
        if not lang_ok or not lang then return end

        local parser_ok = pcall(vim.treesitter.language.inspect, lang)
        if not parser_ok then
            vim.notify("Installing Tree-sitter parser for: " .. lang, vim.log.levels.INFO)
            vim.cmd("TSInstall " .. lang)
        end
    end,
})

return M


