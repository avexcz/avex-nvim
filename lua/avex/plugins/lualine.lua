local status, lualine = pcall(require, "lualine")
if not status then 
    return
end

local function get_error_location()
  local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  if #diagnostics == 0 then
    return ""
  end
  local line = diagnostics[1].lnum + 1
  local col = diagnostics[1].col + 1
  return string.format(" %d:%d", line, col)
end

lualine.setup({
  options = {
    theme = "auto",
    globalstatus = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      {
        function()
          return "󰌌 <space> ` for diagnostics" 
        end,
      },
        { 'filename', path = 1, 
            symbols = {
          unnamed = 'No File',
          readonly = '󰌾',
          modified = '',
          newfile = '󰎔',
        }
    },

      {
        get_error_location,
        color = { fg = '#ff5189', gui = 'bold' },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      },
      'encoding',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})
