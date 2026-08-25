return {
	{
		-- https://github.com/catppuccin/nvim
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		--- @type CatppuccinOptions
		opts = {
			flavour = "latte",
			background = {
				light = "latte",
				dark = "macchiato",
			},
			term_colors = true,
			lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			integrations = {
				alpha = true,
				blink_cmp = {
					style = "bordered",
				},
				blink_indent = true,
				diffview = true,
				dropbar = true,
				fzf = true,
				gitsigns = true,
				grug_far = true,
				neotree = true,
				neotest = true,
				neogit = true,
				dap = true,
				telescope = true,
				lsp_trouble = true,
				which_key = true,
				-- lualine = true,
				illuminate = true,
			},
		},
        --- @param Options CatppuccinOptions
        config = function (_,Options)
            require("catppuccin").setup(Options)
        end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"goolord/alpha-nvim",
		config = function()
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"",
				"▗▖  ▗▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖",
				"▐▛▚▖▐▌▐▌   ▐▌ ▐▌▐▌  ▐▌  █  ▐▛▚▞▜▌",
				"▐▌ ▝▜▌▐▛▀▀▘▐▌ ▐▌▐▌  ▐▌  █  ▐▌  ▐▌",
				"▐▌  ▐▌▐▙▄▄▖▝▚▄▞▘ ▝▚▞▘ ▗▄█▄▖▐▌  ▐▌",
				"                                 ",
			}
			dashboard.section.buttons.val = {
				dashboard.button("n", "  > New file", ":enew<CR>"),
				dashboard.button("f", "󰈞  > Find file", ":FzfLua files<CR>"),
				dashboard.button("r", "  > Sessions", ":Telescope persisted<CR>"),
				dashboard.button("p", "󰏓  > Mason Package Manager", ":Mason<CR>"),
				dashboard.button("l", "  > Plugins Manager", ":Lazy<CR>"),
				dashboard.button("s", "  > Settings", ":e $MYVIMRC | cd %:p:h | Neotree show<CR>"),
				dashboard.button("q", "󰿅  > Quit NVIM", ":qa<CR>"),
			}
			require("alpha").setup(dashboard.config)
		end,
	},
}
