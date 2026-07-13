require("luasnip.loaders.from_vscode").load({
	paths = {
		vim.fn.stdpath("config") .. "/Snippets",
		"./Snippets",
	},
})
ls = require("luasnip")
ls.filetype_extend("c", { "c_ext" })
