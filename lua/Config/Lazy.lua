-- Bootstrap lazy.nvim

local LazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(LazyPath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, LazyPath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(LazyPath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
---@type LazyConfig
require("lazy").setup({
	spec = {
		{ import = "Plugins.Theme" },
		{ import = "Plugins.Treesitter" },
		{ import = "Plugins.Editor" },
		{ import = "Plugins.EditorEx" },
		{ import = "Plugins.VSC" },
		{ import = "Plugins.Session" },
		{ import = "Plugins.Format" },
		{ import = "Plugins.CMP" },
		{ import = "Plugins.LSP" },
		{ import = "Plugins.Test" },
		{ import = "Plugins.PackageManager" },
		{ import = "Plugins.Terminal" },
		-- { import = "Plugins.InputMethod" },
		{ import = "Plugins.RunCodeAndDebug" },
		{ import = "Plugins.Languages.LuaNeovim" },
		{ import = "Plugins.Languages.Cpp" },
		{ import = "Plugins.Languages.Json" },
		{ import = "Plugins.Languages.Markdown" },
		-- { import = "Plugins.Languages.CSharp" },
		-- { import = "Plugins.Optional.AI" },
		-- { import = "Plugins.Optional.EMail" },
	},
	rocks = {
		server = "https://rimeinn.github.io/rime.nvim/",
	},
})
