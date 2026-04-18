vim.g.mapleader = " "
im.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) --disable spacebar moving

local keymap = vim.keymap 
local wk = require("which-key")

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

--open dashboard
vim.keymap.set("n", "<C-d>", "<cmd>Alpha<cr>", { desc = "Open Dashboard" })

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
keymap.set({"n", "v"}, "<leader>se", "<C-w>=", {desc = "Resize window at equal width" })  -- resize windows at equal width
keymap.set({"n", "v"}, "<leader>sx", ":close<CR>", {desc = "Close current window"} ) -- close current window


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
keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close Current Tab" })
keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Tab" })
keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Tab" })

--indentation
keymap.set("v", "<leader><Tab>", ">gv", {desc = "Add indentation" })  -- add indent
keymap.set("v", "<leader><S-Tab>", "<gv", {desc = "Remove Indentation" }) -- remove indent


--text
keymap.set("n", "<leader>a", "ggVG", {desc = "Select All" })  -- select all
keymap.set({"n", "v"}, "<leader>y", '"+y', {desc = "Copy" })  -- copy in normal or visual mode
keymap.set({"n", "v"}, "<leader>p", '"+p', { desc = "Paste"})  -- paste in normal or visual mode paste


--folder mapping
keymap.set({"n", "v"}, "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })         -- open folder tree

vim.keymap.set("n", "<leader>fn", function()
    vim.ui.input({ prompt = "New Folder Name: " }, function(input)
        if input and input ~= "" then
            vim.fn.mkdir(input, "p")
            print("Folder created: " .. input)
        end
    end)
end, {desc = "create new folder " })                                                                    -- create folder

vim.keymap.set("n", "<leader>rn", function()
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
vim.keymap.set("n", "<leader>n", function()
    local api = require("nvim-tree.api")
    api.tree.open()
    api.fs.create()
end, { desc = "Create file" })                                                               --create file

vim.keymap.set("n", "<leader>r", function()
    local api = require("nvim-tree.api")
    api.tree.open()
    api.fs.rename()
end, {desc = "Rename file" })                                                                --rename file


vim.keymap.set("n", "<leader>d", function()
    local api = require("nvim-tree.api")
    api.tree.open()
    api.fs.delete()
end, {desc = "Delete file" })                                                                --delete file


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
