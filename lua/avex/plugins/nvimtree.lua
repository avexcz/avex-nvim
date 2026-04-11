local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


nvimtree.setup({
  renderer = {
    icons = {
      glyphs = {
        symlink = "🔗",
        bookmark = "🔖",
        folder = {
          arrow_closed = "▶",
          arrow_open = "▼",
          default = "📁",
          open = "📂",
          empty = "📭",
          empty_open = "📬",
          symlink = "🔗",
          symlink_open = "🔓",
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})
