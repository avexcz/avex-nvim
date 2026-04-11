local status_ok, noice = pcall(require, "noice")
if not status_ok then
    return
end

noice.setup({
    lsp = { -- Added the missing 'lsp =' key here
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    }, -- This brace now correctly closes the 'lsp' table
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,      -- CHANGED TO FALSE: This stops the center popup
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
    -- add this to ensure notifications look clean
    messages = {
        enabled = false,
        view = "notify",              -- default view for messages
        view_error = "notify",         -- view for errors
        view_warn = "notify",          -- view for warnings
    },
})
