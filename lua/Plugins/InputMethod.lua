---@type LazySpec
return {
	-- {
	-- 	"rimeinn/rime.nvim",
	-- 	lazy = false,
	--        dependencies = {
	--            "rimeinn/ime.nvim"
	--        },
	-- 	rocks = {
	-- 		"https://rimeinn.github.io/rime.nvim",
	-- 		"https://lumen-oss.github.io/rocks-binaries",
	-- 		"https://luarocks.org",
	-- 	},
	-- 	opts = {},
	-- 	config = function(_, Options)
	-- 		local ui = require("ime.ui")
	-- 		local UI = require("ime.ui.horizontal").UI
	--
	-- 		local rime = require("rime.nvim")
	-- 		rime.rime = { ui = UI({ indices = ui.styles.square }) }
	-- 		vim.keymap.set("i", "<C-F2>", rime.toggle)
	-- 		vim.keymap.set("i", "<C-@>", rime.enable)
	-- 		vim.keymap.set("i", "<C-_>", rime.disable)
	-- 		vim.keymap.set("i", "<C-\\>", rime.callback("<C-\\>"))
	-- 	end,
	-- },
    -- {
	-- 	"saghen/blink.cmp",
	-- 	dependencies = {
	-- 		"rimeinn/rime.nvim",
	-- 	},
	-- 	optional = true,
	-- 	---@type fun(param:table,param:blink.cmp.Config)
	-- 	opts = function(_, Options)
	-- 		table.insert(Options.sources.default, "rime")
	-- 		Options.sources.providers.rime = {
	-- 			name = "rime",
	-- 			module = "blink.compat.source",
	-- 		}
	-- 	end,
	-- },
    {
        "black-desk/fcitx5-ui.nvim",
        lazy = false,
    }
}
