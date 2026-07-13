---@type LazySpec
return {
	{
		"yousefakbar/notmuch.nvim",
		opts = {},
		config = function(_, Options)
			require("notmuch").setup(Options)
		end,
	},
    {
        "neomutt/neomutt.vim"
    }
}
