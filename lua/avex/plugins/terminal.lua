local status, toggleterm = pcall(require, "toggleterm")
if not status then return end

toggleterm.setup({
    size = 10,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
})

