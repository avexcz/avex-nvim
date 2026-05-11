-- alpha dashboard
local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local dashboard = require("alpha.themes.dashboard")

-- Avex ASCII Logo
dashboard.section.header.val = {
    [[]], [[]], [[]], [[]], [[]], [[]],
    [[   ▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖ ]],
    [[  ▐▌ ▐▌▐▌  ▐▌▐▌    ▝▚▞▘  ]],
    [[  ▐▛▀▜▌▐▌  ▐▌▐▛▀▀▘  ▐▌   ]],
    [[  ▐▌ ▐▌ ▝▚▞▘ ▐▙▄▄▖▗▞▘▝▚▖ ]],                   
}

-- helper for buttons
local function blue_button(sc, txt, keybind)
    local b = dashboard.button(sc, txt, keybind)
    b.opts.hl = "Function"      -- bright blue for the icons
    b.opts.hl_shortcut = "SpellLocal" -- blue underline for shortcut 
    return b
end

-- project path
local function avex_project_search()
    local home = vim.fn.expand("$HOME")
    local default_path = home .. "/Documents/Project"
    
    vim.ui.input({ 
        prompt = '󰚝 Your Project Path: ', 
        default = default_path,
        completion = "dir" 
    }, function(input)
        if input == nil or input == "" then return end

        if vim.fn.isdirectory(input) == 1 then
            vim.cmd("cd " .. input)
            vim.cmd("Telescope find_files")
        else
            vim.ui.input({
                prompt = "Warning: Path does not exist: Create it? (y/n): ",
            }, function(confirm)
                if confirm ~= nil and confirm:lower() == 'y' then
                    vim.fn.mkdir(input, "p")
                    vim.cmd("cd " .. input)
                    print("Created and moved to: " .. input)
                    vim.cmd("Telescope find_files")
                else
                    print("Operation cancelled")
                end
            end)
        end
    end)
end

-- dashboard section
dashboard.section.buttons.val = {
    blue_button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
    blue_button("n", "  New file", ":enew | startinsert<CR>"),
    blue_button("r", "󰄉  Time machine", ":Telescope oldfiles<CR>"),
    blue_button("p", "  Project", function() avex_project_search() end),
    blue_button("t", "  Terminal", ":ToggleTerm direction=float<CR>"),
    blue_button("x", "  Find text", ":Telescope live_grep<CR>"),
    blue_button("c", "  Configuration", ":e " .. vim.fn.stdpath("config") .. "/init.lua<CR>"),
    blue_button("q", "󰈆  Quit", ":qa<CR>"),
}

-- footer section
local function footer()
    local greeting = "                    Welcome to Avex's Neovim"
    local help = "Click v and <leader>? (space + shift + ?) for keyboard shortcuts"
    return { greeting, " ", help }
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.position = "center"

-- Highlights
dashboard.section.header.opts.hl = "Function" -- Blue Header
dashboard.section.footer.opts.hl = "EndOfBuffer" -- Grey Footer

-- Final setup
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.config or dashboard.opts)
