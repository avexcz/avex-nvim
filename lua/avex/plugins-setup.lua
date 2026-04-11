--Autocommand that reloads neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
    --packer
    use("wbthomason/packer.nvim")

    --dashboard entry
 --   use("glepnir/dashboard-nvim")
    use(
    -- Alpha (Dashboard)
    {"goolord/alpha-nvim",
        lazy = true})


    --theme
    use("bluz71/vim-nightfly-guicolors")
    
    --folder tree explorer
    use("nvim-tree/nvim-tree.lua")
    use("kyazdani42/nvim-web-devicons")

    --better commenting with gc
    use("numToStr/Comment.nvim")

    --statusline
    use("nvim-lualine/lualine.nvim")

    --autocompletion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")

    --snippet
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")
    use("saadparwaiz1/cmp_luasnip")

    --lsp servers
    use("williamboman/mason.nvim")
    use("neovim/nvim-lspconfig")
    use("williamboman/mason-lspconfig.nvim")
    use("hrsh7th/cmp-nvim-lsp")

    --fuzzy finding
    use({
  "nvim-telescope/telescope.nvim",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
  }
})
    
    --terminal
    use({
  "akinsho/toggleterm.nvim",
  tag = "*",
})

--bufferline
use({
  "akinsho/bufferline.nvim",
  tag = "*",
  requires = "nvim-tree/nvim-web-devicons",
})

    
 --shortcut cheatsheet and it's small configurations 
    use({
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup({
      triggers = {},

      show_help = false,
      show_keys = false,

      win = {
        border = "rounded",
        padding = { 1, 2 },
        title = " Avex's Shortcuts ",
        title_pos = "center",
      },

      layout = {
        width = { min = 20, max = 50 },
        align = "center",
      },
        filter = function(mapping)
    if mapping.group then
      return false
    end

    if mapping.desc == nil then
      return false
    end

    return true
    end,
    })
  end,
})


    --treesitter
    use({"nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate" })
    
   --Custom command
    use({"folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
  },
})






    if packer_bootstrap then
        require("packer").sync()
    end
end)

