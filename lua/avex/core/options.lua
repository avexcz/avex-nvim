  local opt = vim.opt --for conciseness
  
     --line numbers
opt.relativenumber = true
opt.number = true
    
     --tab & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
   
   --line wrapping
opt.wrap = false
  
   --search settings
opt.ignorecase = true
opt.smartcase = true
   
   --cursor line
opt.cursorline = true
   
--tab in-built display
--vim.o.showtabline = 2

--appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
  
   --backspace
opt.backspace = "indent,eol,start"
 
  --split windows
opt.splitright = true
opt.splitbelow = true

--Global hide
vim.diagnostic.enable(false)

opt.cmdheight = 1
opt.shortmess = "aoOTI"
opt.more = true
--stop swap file (optional)
--vim.opt.swapfile = false
