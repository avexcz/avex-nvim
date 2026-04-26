vim.g.mapleader = " "

local keymap = vim.keymap 
local wk = require("which-key")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) --disable spacebar moving

--quick plugin install
function _G.EditPlugins()
    local plugin_path = vim.fn.stdpath("config") .. "/lua/avex/plugins-setup.lua"
    local buf = vim.fn.bufadd(plugin_path)
    vim.fn.bufload(buf)
    
    local width = math.ceil(vim.o.columns * 0.8)
    local height = math.ceil(vim.o.lines * 0.8)
    
    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = math.ceil((vim.o.columns - width) / 2),
        row = math.ceil((vim.o.lines - height) / 2),
        style = "minimal",
        border = "rounded",
    })
end

vim.keymap.set("n", "<leader>P", _G.EditPlugins, {
  desc = "Open plugin config",
  noremap = true,
  silent = true,
})


--line
--line up/down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

--move to end of right/left
keymap.set({"n", "v"}, "}", "$",  { desc = "Move to end of line" })     -- Move to end of line (right)
keymap.set({"n", "v"}, "{", "^",  { desc = "Move to start of line" })   -- Move to start of line (left)
keymap.set({"n", "v"}, "<leader>H", "0",  { desc = "Move to column 0" })        -- Move to absolute start of line (column 0)

--jump to next/prev paragraph
keymap.set({"n", "v"}, "\\", "{", { desc = "Jump to prev paragraph", noremap = true })
keymap.set({"n", "v"}, "|",  "}", { desc = "Jump to next paragraph", noremap = true })

-- Replaces every occurrence of word under cursor in the file
keymap.set("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Replace word under cursor" })

-- copy and cut
keymap.set("n", "<leader>x",  '"+dd', { desc = "Cut line to clipboard" })
keymap.set("v", "<leader>x",  '"+d',  { desc = "Cut selection to clipboard" })    
    
-- centered half page scroll
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page" })


--open dashboard
vim.keymap.set("n", "<leader>da", "<cmd>Alpha<cr>", { desc = "Open Dashboard" })

--general keymaps
keymap.set({"n", "v"}, "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set({"n", "v"}, "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap.set({"n", "v"}, "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })


--toggle my local cheatsheet anywhere
--AVEX's mapping
vim.keymap.set("n", "<leader>?", function()
  wk.show("<leader>")
end, { desc = "Show keymaps" })

--ALL mapping
vim.keymap.set("v", "<leader>?", function()
  require("which-key").show()
end, { desc = "All keymaps" })

--window
keymap.set({"n", "v"}, "<leader>sv", "<C-w>v", {desc = "Spilt into vertical window" }) -- split into vertical window
keymap.set({"n", "v"}, "<leader>sh", "<C-w>s", {desc = "Split into horizontal window" } ) -- split into horizontal window
keymap.set({"n", "v"}, "<leader>s=", "<C-w>=", {desc = "Resize window at equal width" })  -- resize windows at equal width
keymap.set({"n", "v"}, "<leader>sx", ":close<CR>", {desc = "Close current window"} ) -- close current window
keymap.set("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Increase window height" })
keymap.set("n", "<C-Down>",  "<cmd>resize -2<cr>",          { desc = "Decrease window height" })
keymap.set("n", "<C-]>",  "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-[>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
keymap.set("n", "<C-a>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-d>", "<C-w>l", { desc = "Move to right window" })

--tab
keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Tab 1" })
keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Tab 2" })
keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Tab 3" })
keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Tab 4" })
keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Tab 5" })
keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Tab 6" })
keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Tab 7" })
keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Tab 8" })
keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Tab 9" })
keymap.set("n", "<leader>0", "<cmd>BufferLineGoToBuffer -1<cr>", { desc = "Last Tab" })
keymap.set("n", "<leader>X", "<cmd>bdelete<cr>", { desc = "Close Current Tab" })
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Tab" })
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Tab" })

--Telescope keymapping
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   { desc = "Live grep" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",   { desc = "Help tags" })
keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>",    { desc = "Recent files" })
keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>",    { desc = "Commands" })

--text
keymap.set("n", "<leader>a", "ggVG", {desc = "Select All" })  -- select all
keymap.set({"n", "v"}, "<leader>y", '"+y', {desc = "Copy" })  -- copy in normal or visual mode
keymap.set({"n", "v"}, "<leader>p", '"+p', { desc = "Paste"})  -- paste in normal or visual mode paste


--folder mapping
keymap.set({"n", "v"}, "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })         -- open folder tree

vim.keymap.set("n", "<leader>dn", function()
    vim.ui.input({ prompt = "New Folder Name: " }, function(input)
        if input and input ~= "" then
            vim.fn.mkdir(input, "p")
            print("Folder created: " .. input)
        end
    end)
end, {desc = "create new folder " })                                                                    -- create folder

vim.keymap.set("n", "<leader>dr", function()
    local old_name = vim.fn.expand("<cfile>") -- Gets name under cursor
    if old_name == "" then print("No file/folder under cursor") return end
    vim.ui.input({ prompt = "Rename " .. old_name .. " to: ", default = old_name }, function(new_name)
        if new_name and new_name ~= "" then
            os.rename(old_name, new_name)
            print("Renamed to: " .. new_name)
        end
    end)
end, { desc = "Rename folder/file" })                                                                    -- rename folder

vim.keymap.set("n", "<leader>rf", function()
    local folder = vim.fn.expand("<cfile>")
    if folder == "" then print("No folder under cursor") return end
    local full_path = vim.fn.fnamemodify(folder, ":p")

    vim.ui.input({ prompt = "Move '" .. folder .. "' to trash? (y/n): "}, function(input)
        if input == "y" then
            local cmd = string.format("osascript -e 'tell application \"Finder\" to move POSIX file \"%s\" to trash'", full_path)
            local success = os.execute(cmd)
            if success then 
                print("Moved to trash: " .. folder)
            else
                print("Could not move to trash.")
            end
        end
    end)
end, {desc = "Move folder to trash" })                                                                   -- delete folder


--file mapping
vim.keymap.set("n", "<leader>fn", function()
    local api = require("nvim-tree.api")
    api.tree.open()
    api.fs.create()
end, { desc = "Create file" })                                                               --create file

vim.keymap.set("n", "<leader>fr", function()
    local api = require("nvim-tree.api")
    api.tree.open()
    api.fs.rename()
end, {desc = "Rename file" })                                                                --rename file


vim.keymap.set("n", "<leader>fd", function()
    local api = require("nvim-tree.api")
    api.tree.open()
    api.fs.delete()
end, {desc = "Delete file" })                                                                --delete file

-- save
keymap.set("n", "<leader>w", "<cmd>w<CR>",  { desc = "Save file" })
keymap.set("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save all files" })
keymap.set("n", "<C-s>",     "<cmd>w<CR>",  { desc = "Save file" })

-- quit
keymap.set("n", "<leader>q",  "<cmd>q<CR>",  { desc = "Quit" })
keymap.set("n", "<leader>Q",  "<cmd>qa!<CR>", { desc = "Force quit all" })
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and quit" })

-- source current file
keymap.set("n", "<leader>so", "<cmd>source %<CR>", { desc = "Source current file" })

-- make file executable
keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

--quick fix
keymap.set("n", "<leader>co", "<cmd>copen<cr>",  { desc = "Open quickfix list" })
keymap.set("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Close quickfix list" })
keymap.set("n", "]q",         "<cmd>cnext<cr>",  { desc = "Next quickfix item" })
keymap.set("n", "[q",         "<cmd>cprev<cr>",  { desc = "Prev quickfix item" })

-- redo
keymap.set("n", "U", ":redo<CR>", { desc = "Redo" })

--terminal
vim.keymap.set("n", [[<leader>\]], ":ToggleTerm<CR>", {desc = "Toggle terminal" })


-- comment keymapping
-- Toggle comment for the current line in normal mode
vim.keymap.set("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment linewise" })

-- Toggle comment for selected lines in visual mode
vim.keymap.set("v", "<leader>/", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment linewise visually" })


--find text
--keymap.set("n", "<leader>f", "/", {desc = "find text" })

--hide and show warning
vim.keymap.set("n", "<leader>`", function()
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(false)
        print("Diagnostics and warning Hidden")
    else
        vim.diagnostic.enable(true)
        print("Diagnostics and warning Shown")
    end
end, { desc = "Toggle Diagnostics" })


-- git keybinds
keymap.set("n", "<leader>gs",  "<cmd>Git<cr>",            { desc = "Git status" })
keymap.set("n", "<leader>gb",  "<cmd>Git blame<cr>",      { desc = "Git blame" })
keymap.set("n", "<leader>gd",  "<cmd>Gitsigns diffthis<cr>", { desc = "Git diff" })
keymap.set("n", "<leader>gp",  "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk" })
keymap.set("n", "]h",          "<cmd>Gitsigns next_hunk<cr>",    { desc = "Next git hunk" })
keymap.set("n", "[h",          "<cmd>Gitsigns prev_hunk<cr>",    { desc = "Prev git hunk" })

-- Run macro in q register quickly
keymap.set("n", "Q", "@q", { desc = "Run macro in q register" })
