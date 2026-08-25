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
vim.api.nvim_create_augroup("DefaultClipboard", {
	clear = true,
})
vim.api.nvim_create_autocmd("BufEnter", {
	group = "DefaultClipboard",
	pattern = {
		"man",
	},
	---@param Arguments vim.api.keyset.create_autocmd.callback_args
	callback = function(Arguments)
		vim.o.clipboard = "unnamedplus"
		-- vim.bo.clipboard:append("unnamedplus")
	end,
})
vim.api.nvim_create_autocmd("BufLeave", {
	group = "DefaultClipboard",
	pattern = {
		"man",
	},
	---@param Arguments vim.api.keyset.create_autocmd.callback_args
	callback = function(Arguments)
		vim.o.clipboard = "unnamed"
		-- vim.bo.clipboard:append("unnamedplus")
	end,
})
