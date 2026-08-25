return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		optional = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		---@type fun(param:table,param:render.md.Config)
		opts = function(_, Options)
			table.insert(Options.file_types, "codecompanion")
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-treesitter/nvim-treesitter",
			-- "github/copilot.vim",
		},
		opts = {
			-- NOTE: The log_level is in `opts.opts`
			opts = {
				log_level = "DEBUG", -- or "TRACE"
			},
			language = "Chinese",
			strategies = {
				chat = { adapter = "deepseek" },
				inline = { adapter = "deepseek" },
				agent = { adapter = "deepseek" },
			},
		},
		keys = {},
	},
	{
		"saghen/blink.cmp",
		optional = true,
		---@type fun(param:table,param:blink.cmp.Config)
		---@param Options blink.cmp.Config
		opts = function(_, Options)
			Options = Options or {}
			Options.sources = Options.sources or {}
			Options.sources.default = Options.sources.default or {}
			Options.sources.providers = Options.sources.providers or {}

			table.insert(Options.sources.default, 1, "codecompanion")
			Options.sources.providers.codecompanion = {
				name = "CodeCompanion",
				module = "codecompanion.providers.completion.blink",
			}
		end,
		---@type fun(param:table,param:blink.cmp.Config)
		---@param Options blink.cmp.Config
		config = function(_, Options)
			require("blink-cmp").setup(Options)
		end,
	},
}
