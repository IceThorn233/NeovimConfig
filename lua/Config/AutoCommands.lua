vim.api.nvim_create_augroup("GitCommit", {
	clear = true,
})
vim.api.nvim_create_autocmd("BufEnter", {
	group = "GitCommit",
	pattern = {
		"gitcommit",
	},
	callback = function()
		vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
	end,
})
