return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "2.*",
		lazy = false,
		opts = {},
		config = function(_, Options)
			require("luasnip").filetype_extend("c", { "cdoc" })
			require("luasnip").filetype_extend("cpp", { "cppdoc" })
			require("luasnip").filetype_extend("cs", { "csharp", "csharpdoc" })
			require("luasnip").filetype_extend("csharp", { "csharp", "csharpdoc" })
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load()
			vim.api.nvim_create_user_command("LuaSnipReload", function(args)
				require("luasnip.loaders.from_vscode").load()
				require("luasnip.loaders.from_snipmate").load()
				require("luasnip.loaders.from_lua").load()
			end, { desc = "Reload vscode style snippets." })
		end,
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"bydlw98/blink-cmp-env",
			"saghen/blink.compat",
			"L3MON4D3/LuaSnip",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = {
				preset = "luasnip",
			},
			keymap = {
				preset = "none",
				["<A-k>"] = { "select_prev", "fallback" },
				["<A-j>"] = { "select_next", "fallback" },
				["<UP>"] = { "select_prev", "fallback" },
				["<DOWN>"] = { "select_next", "fallback" },
				["<TAB>"] = { "accept", "snippet_forward", "fallback" },
				["<S-TAB>"] = { "snippet_backward", "fallback" },
				["<ESC>"] = { "fallback" },
				["<A-n>"] = { "scroll_documentation_down", "fallback" },
				["<A-p>"] = { "scroll_documentation_up", "fallback" },
				["<A-SPACE>"] = { "show" },
				["<C-SPACE>"] = { "hide" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "inherit",
				},
				completion = {
					ghost_text = {
						enabled = true,
					},
					menu = {
						auto_show = true,
					},
				},
			},
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 1,
					treesitter_highlighting = true,
					window = {
						min_width = 60,
						max_width = 75,
						max_height = 40,
						border = "rounded",
					},
				},
				trigger = {
					show_on_keyword = true,
				},
				ghost_text = {
					enabled = true,
					show_with_menu = true,
				},
				menu = {
					enabled = true,
					border = "rounded",
					scrollbar = true,
					max_height = 30,
					min_width = 30,
					scrolloff = 4,
				},
				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
			},
			sources = {
				per_filetype = {},
				default = {
					"lsp",
					"path",
					"env",
					"snippets",
					"buffer",
				},
				providers = {
					env = {
						name = "Env",
						module = "blink-cmp-env",
						--- @type blink-cmp-env.Options
						opts = {},
					},
					snippets = {},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
