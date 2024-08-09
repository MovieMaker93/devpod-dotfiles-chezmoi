vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "gl", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gr", "<cmd>diffget //3<CR>")
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
