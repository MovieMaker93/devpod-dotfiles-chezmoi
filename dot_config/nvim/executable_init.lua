vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

---@type string -- Path of the neovim config folder (`~/.config/nvim`).
NeovimPath = vim.fn.stdpath("config")
-- Set global variables for vimscript env
vim.api.nvim_set_var("NeovimPath", NeovimPath)

require("lazy").setup("plugins", opts)
require("devfortunato")
require("utils")
-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
--
