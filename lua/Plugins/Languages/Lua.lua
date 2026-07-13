return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		lazy = false,
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "lazy.nvim", words = { "lazy.nvim" } },
				{ path = "nvim-lspconfig", words = { "lspconfig.settings" } },
			},
		},
	},
	-- { -- optional cmp completion source for require statements and module annotations
	-- 	"hrsh7th/nvim-cmp",
	-- 	opts = function(_, opts)
	-- 		opts.sources = opts.sources or {}
	-- 		table.insert(opts.sources, {
	-- 			name = "lazydev",
	-- 			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
	-- 		})
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
		optional = true,
		dependencies = {
			"folke/lazydev.nvim",
		},
        ---@type fun(table,blink.cmp.Config)
        ---@param Options blink.cmp.Config
		opts = function(_, Options)
            Options = Options or {}
            Options.sources = Options.sources or {}
            Options.sources.per_filetype = Options.sources.per_filetype or {}
            Options.sources.providers = Options.sources.providers or {}
			Options.sources.per_filetype.lua = {
				inherit_defaults = true,
				"lazydev",
			}
			Options.sources.providers.lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			}
		end,
	},
}
