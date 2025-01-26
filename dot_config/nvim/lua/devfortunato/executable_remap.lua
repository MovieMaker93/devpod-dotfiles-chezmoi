-- Move current line up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Navigate between quickfix items
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })

-- -- Navigate between location list items
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Forward location list" })
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Backward location list" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Save current selection to copy clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>rp", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- Resize windows
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

-- Rename incremental
vim.keymap.set("n", "<leader>rn", ":IncRename ")

-- Split vertical and horizontal
vim.keymap.set("n", "<leader>sh", "<cmd>new<CR>")
vim.keymap.set("n", "<leader>sv", "<cmd>vnew<CR>")

-- Go test run
vim.keymap.set("n", "<leader>gtr", "<cmd>GoTestRun<CR>")

-- Enable inline hint
vim.keymap.set("n", "<leader>ti", "<cmd>EnableInline<CR>")

-- exit file/inspect current tree
vim.keymap.set("n", "<leader>i", vim.cmd.InspectTree)

-- vim.keymap.set("n", "gb", "<Cmd>BufferLinePick<CR>")
vim.keymap.set("n", "gb", function()
	local user_input = vim.fn.input("Enter buffer number: ")
	vim.api.nvim_command("BufferLineGoToBuffer" .. user_input)
end)
vim.keymap.set("n", "gn", "<Cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "gp", "<Cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "gd", "<Cmd>BufferLinePickClose<CR>")
