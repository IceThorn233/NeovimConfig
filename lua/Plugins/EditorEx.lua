return {
	{
		"MagicDuck/grug-far.nvim",
		opts = {
			headerMaxWidth = 80,
		},
		keys = {},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {},
		lazy = false,
		--- @type bufferline.UserConfig
		opts = {
			highlights = require("catppuccin.special.bufferline").get_theme(),
			options = {
				right_mouse_command = nil,
				middle_mouse_command = "Bdelete! %d",
				close_command = "Bdelete! %d",
				separator_style = "slant",
				tab_size = 14,
				max_name_length = 40,
				indicator = {
					style = "underline",
				},
				custom_filter = function(bufferName, bufferNumber)
					if
						vim.bo[bufferName].filetype == "grug-far"
						or vim.bo[bufferName].filetype == "checkhealth"
						or vim.bo[bufferName].filetype == "help"
						or vim.bo[bufferName].filetype == "better_term"
						or vim.bo[bufferName].filetype == "dapui_scopes"
						or vim.bo[bufferName].filetype == "dapui_breakpoints"
						or vim.bo[bufferName].filetype == "dapui_stacks"
						or vim.bo[bufferName].filetype == "dapui_watches"
						or vim.bo[bufferName].filetype == "dap-repl"
						or vim.bo[bufferName].filetype == "dapui_console"
					then
						return false
					end
					return true
				end,
				offsets = {
					-- {
					-- 	filetype = "neo-tree",
					-- 	text = "Explorer",
					-- 	text_align = "center",
					-- 	separator = true,
					-- },
				},
				numbers = function(opts)
					return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
				end,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					return " " .. (level:match("error") and " " or " ") .. count
				end,
				custom_areas = {
					left = function()
						return vim.tbl_map(function(item)
							return { text = item }
						end, require("edgy-group.stl").get_statusline("left"))
					end,
					right = function()
						return vim.tbl_map(function(item)
							return { text = item }
						end, require("edgy-group.stl").get_statusline("right"))
					end,
				},
				pick = {
					alphabet = "asdfghjkl",
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
		},
	},
	{
		"wsdjeg/bufdel.nvim",
		cmd = { "Bdelete", "Bwipeout" },
		keys = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "catppuccin",
			},
			sections = {
				lualine_x = {
					"encoding",
					"fileformat",
					"filetype",
					{
						function()
							local stl = require("edgy-group.stl")
							local bottom_line = stl.get_statusline("bottom")
							return table.concat(bottom_line)
						end,
					},
				},
			},
		},
	},
	{
		"lucobellic/edgy-group.nvim",
		dependencies = { "folke/edgy.nvim" },
		event = "VeryLazy",
		opts = {
			groups = {
				--- @type EdgyGroup[]ex
				right = {
					{
						icon = " ",
						titles = {
							"Neo-Tree",
						},
					},
					{
						icon = " ",
						titles = {
							"Neo-Tree Symbols",
						},
					},
					{
						icon = "󰛔 ",
						titles = {
							"Find And Replace",
						},
					},
				},
				--- @type EdgyGroup[]
				left = {},
				--- @type EdgyGroup[]
				bottom = {
					{
						icon = " ",
						titles = {
							"Trouble",
						},
						pick_key = "d",
					},
					{
						icon = " ",
						titles = {
							"Task List",
							"Task Console",
						},
						pick_key = "a",
					},
					{
						icon = " ",
						titles = {
							"Toggleterm Terminal",
						},
						pick_key = "t",
					},
					{
						icon = " ",
						titles = {
							"DapView",
						},
						pick_key = "e",
					},
				},
				top = {},
			},
			statusline = {
				clickable = true,
				colored = true,
				colors = {
					active = "PmenuSel",
					inactive = "Pmenu",
				},
				pick_key_pose = "right_separator",
			},
			toggle = true,
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		---@module "fzf-lua"
		---@type fzf-lua.Config|{}
		opts = {},
		keys = {},
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		opts = {
			left = {},
			---@type (Edgy.View.Opts|string)[]
			bottom = {
				{
					title = "Toggleterm Terminal",
					ft = "toggleterm",
					open = "ToggleTerm",
				},
				{
					title = "Task List",
					ft = "OverseerList",
					open = "OverseerOpen",
				},
				{
					title = "Task Console",
					ft = "OverseerOutput",
					open = "OverseerOpen",
				},
				{
					title = "Trouble",
					ft = "trouble",
					open = "Trouble diagnostics toggle auto_close=false auto_jump=true focus=true",
				},
				{
					title = "DapView",
					ft = "dap-view",
					open = "DapViewToggle",
				},
                {
                    title = "DapRepl",
					ft = "dap-repl",
					open = "DapViewToggle",
                },
			},
			---@type (Edgy.View.Opts|string)[]
			right = {
				{
					title = "Find And Replace",
					ft = "grug-far",
					open = "GrugFar",
					size = { width = 0.3 },
				},
				{
					title = "Neo-Tree Symbols",
					ft = "neo-tree",
					open = "Neotree source=document_symbols position=right",
					filter = function(BufferName)
						return vim.b[BufferName].neo_tree_source == "document_symbols"
					end,
				},
				{
					title = "Neo-Tree",
					ft = "neo-tree",
					open = "Neotree source=filesystem position=right",
					filter = function(BufferName)
						return vim.b[BufferName].neo_tree_source == "filesystem"
					end,
				},
				-- {
				-- 	ft = "dapui_scopes",
				-- 	title = "DapuiScopes",
				-- 	open = require("dapui").open,
				-- },
				-- {
				-- 	ft = "dapui_breakpoints",
				-- 	title = "DapuiBreakpoints",
				-- 	open = require("dapui").open,
				-- },
				-- {
				-- 	ft = "dapui_stacks",
				-- 	title = "DapuiStacks",
				-- 	open = require("dapui").open,
				-- },
				-- {
				-- 	ft = "dapui_watches",
				-- 	title = "DapuiWatches",
				-- 	open = require("dapui").open,
				-- },
			},
			top = {},
			---@type vim.wo
			wo = {
				-- winbar = false,
				spell = false,
			},
			animate = {
				enabled = false,
				fps = 60,
				cps = 60,
			},
			---@type table<Edgy.Pos, {size:integer | fun():integer, wo:vim.wo}>
			options = {
				left = { size = 40 },
				bottom = { size = 17 },
				right = { size = 40 },
				top = { size = 10 },
			},
			keys = {
				["<c-Right>"] = function(win)
					win:resize("width", 2)
				end,
				["<c-Left>"] = function(win)
					win:resize("width", -2)
				end,
				["<c-Up>"] = function(win)
					win:resize("height", 2)
				end,
				["<c-Down>"] = function(win)
					win:resize("height", -2)
				end,
			},
		},
		config = function(_, Options)
			local Edgy = require("edgy")
			--- @type Edgy.Config
			Edgy.setup(Options)
		end,
		wo = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
			},
			{
				"nvim-telescope/telescope-dap.nvim",
			},
		},
		opts = function()
			local Telescope = require("telescope")
			Telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<A-j>"] = "move_selection_next",
							["<A-k>"] = "move_selection_previous",
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
					},
				},
			})
			Telescope.load_extension("dap")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
			"3rd/image.nvim",
			{
				"antosha417/nvim-lsp-file-operations",
				optional = true,
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
				opts = {},
			},
		},
		lazy = false, -- neo-tree will lazily load itself
		keys = {},
		opts = {
			filesystem = {
				window = {
					mappings = {
						["<TAB>"] = { "toggle_node", nowait = true },
						["l"] = { "open", nowait = false },
						["h"] = { "close_node", nowait = true },
					},
				},
				commands = {},
			},
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			clipboard = {
				sync = "global", -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
			},
		},
	},
	{
		"3rd/image.nvim",
		opts = {
			backend = "sixel",
		},
	},
	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
				lazy = true,
			},
		},
		---@type YaziConfig | {}
		opts = {
			open_for_directories = false,
			keymaps = {},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
		keys = {},
	},
}
