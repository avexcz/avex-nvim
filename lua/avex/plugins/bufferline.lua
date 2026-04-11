local function setup_bufferline()
  local bufferline = require("bufferline")
  
  --local normal = vim.api.nvim_get_hl(0, { name = "Normal" })

  bufferline.setup({
    options = {
      mode = "buffers",
      numbers = "none",
      indicator = {
        style = "icon",
        icon = "▎",
      },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      separator_style = "rounded",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = false,
        },
        --{
        --  filetype = "alpha",
        --  text = "Avex",
        --  text_align = "center",
        --  separator = false,
       --},
      },
    },
    highlights = {
    fill = { link = 'Normal' },
    background = { link = 'Normal' },
    buffer_visible = { link = 'Normal' },
    buffer_selected = { 
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
      bold = true, 
      italic = false 
    },
    separator = { 
      fg = { attribute = "bg", highlight = "Normal" }, 
      bg = { attribute = "bg", highlight = "Normal" } 
    },
    separator_visible = { 
      fg = { attribute = "bg", highlight = "Normal" }, 
      bg = { attribute = "bg", highlight = "Normal" } 
    },
    separator_selected = { 
      fg = { attribute = "bg", highlight = "Normal" }, 
      bg = { attribute = "bg", highlight = "Normal" } 
    },
  },

  })
end

setup_bufferline()

