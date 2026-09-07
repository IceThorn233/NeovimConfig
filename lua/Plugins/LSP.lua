---@type LazySpec
return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"lemminx",
				"bashls",
				"texlab",
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				markdown = { "markdownlint-cli2" },
				cpp = {
					"clangtidy",
				},
				c = {
					"clangtidy",
				},
			}
			require("lint").linters.clangtidy.args = {
				"--quiet",
				"-p",
				"build",
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "ibhagwan/fzf-lua" },
		},
		event = "LspAttach",
		opts = {},
	},
	{
		"smjonas/inc-rename.nvim",
		opts = {},
	},
	{
		"Bekaboo/dropbar.nvim",
		opts = {},
	},
	-- {
	-- 	"Fildo7525/pretty_hover",
	-- 	event = "LspAttach",
	-- 	opts = {},
	-- 	config = function(_, PrettyHoverOptions)
	-- 		require("pretty_hover").setup(PrettyHoverOptions)
	-- 		-- vim.keymap.set("n", "K", require("pretty_hover").hover, { noremap = true, silent = true })
	-- 		--          local parsed = require("pretty_hover.parser").parse(text)
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"bydlw98/blink-cmp-env",
			"saghen/blink.compat",
			"L3MON4D3/LuaSnip",
			"pretty_hover",
		},
		optional = true,
		---@param BlinkCmpOptions blink.cmp.Config
		opts = function(_, BlinkCmpOptions)
			BlinkCmpOptions = BlinkCmpOptions or {}
			BlinkCmpOptions.completion = BlinkCmpOptions.completion or {}
			BlinkCmpOptions.completion.documentation = BlinkCmpOptions.completion.documentation or {}
			BlinkCmpOptions.completion.documentation.draw = function(Options)
				if Options.item and Options.item.documentation and Options.item.documentation.value then
					local Output = require("pretty_hover.parser").parse(Options.item.documentation.value)
					Options.item.documentation.value = Output:string()
				end
				Options.default_implementation(Options)
			end
		end,
	},
	-- {
	-- 	"lewis6991/hover.nvim",
	-- 	config = function(_, Options)
	-- 		require("hover").config({
	-- 			--- List of modules names to load as providers.
	-- 			--- @type (string|Hover.Config.Provider)[]
	-- 			providers = {
	-- 				"hover.providers.diagnostic",
	-- 				"hover.providers.lsp",
	-- 				"hover.providers.dap",
	-- 				"hover.providers.man",
	-- 				"hover.providers.dictionary",
	-- 			},
	-- 			preview_window = false,
	-- 			title = true,
	-- 			mouse_providers = {
	-- 				"hover.providers.lsp",
	-- 			},
	-- 			mouse_delay = 1000,
	-- 		})
	-- 		-- Setup keymaps
	-- 		vim.keymap.set("n", "K", function()
	-- 			require("hover").open()
	-- 		end, { desc = "hover.nvim (open)" })
	--
	-- 		vim.keymap.set("n", "gK", function()
	-- 			require("hover").enter()
	-- 		end, { desc = "hover.nvim (enter)" })
	--
	-- 		vim.keymap.set("n", "<A-p>", function()
	-- 			require("hover").switch("previous")
	-- 		end, { desc = "hover.nvim (previous source)" })
	--
	-- 		vim.keymap.set("n", "<A-n>", function()
	-- 			require("hover").switch("next")
	-- 		end, { desc = "hover.nvim (next source)" })
	--
	-- 		-- Mouse support
	-- 		-- vim.keymap.set("n", "<MouseMove>", function()
	-- 		-- 	require("hover").mouse()
	-- 		-- end, { desc = "hover.nvim (mouse)" })
	--
	-- 		vim.o.mousemoveevent = true
	-- 	end,
	-- },
}
