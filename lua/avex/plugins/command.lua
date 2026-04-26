local status_ok, noice = pcall(require, "noice")
if not status_ok then
    return
end

noice.setup({
    lsp = { 
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,        
        command_palette = true,      
        long_message_to_split = true,
        inc_rename = false,          
        lsp_doc_border = false,
    },
    messages = {
        enabled = true,
        view = "notify",              -- default view for messages
        view_error = "notify",         -- view for errors
        view_warn = "notify",          -- view for warnings
    },
})

require("notify").setup({
  background_colour = "#000000",
})

