--site path
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/site")

-- plugins
require("avex.plugins-setup")
require("avex.plugins.nvimtree")
require("avex.plugins.comment")
require("avex.plugins.lualine")
require("avex.plugins.alpha-dashboard")
require("avex.plugins.telescope")
require("avex.plugins.cmp")
require("avex.plugins.lsp.mason")
require("avex.plugins.terminal")
require("avex.plugins.syntaxh")
require("avex.plugins.command")
require("avex.plugins.bufferline")

-- core
require("avex.core.options")
require("avex.core.keymaps")
require("avex.core.colorscheme")
require("avex.core.autocommand")

