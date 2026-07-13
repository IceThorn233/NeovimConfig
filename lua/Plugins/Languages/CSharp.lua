---@type LazySpec
return {
	-- {
	-- 	"GustavEikaas/easy-dotnet.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"ibhagwan/fzf-lua",
	-- 	},
	-- 	build = "dotnet tool install -g EasyDotnet",
	-- 	opts = {
	-- 		projx_lsp = {
	-- 			enabled = true,
	-- 		},
	-- 		lsp = {
	-- 			enable = false,
	-- 		},
	-- 		picker = "fzf",
	-- 	},
	-- 	config = function(_, Options)
	-- 		require("easy-dotnet").setup(Options)
	-- 	end,
	-- },
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	dependencies = {
	-- 		"GustavEikaas/easy-dotnet.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	optional = true,
	-- 	---@param Options neotree.Config
	-- 	opts = function(_, Options)
	-- 		Options.filesystem = Options.filesystem or {}
	-- 		Options.filesystem.window = Options.filesystem.window or {}
	-- 		Options.filesystem.window.mappings = Options.filesystem.window.mappings or {}
	-- 		Options.filesystem.commands = Options.filesystem.commands or {}
	--
	-- 		Options.filesystem.window.mappings[";"] = "dotnet"
	-- 		Options.filesystem.commands["dotnet"] = function(state)
	-- 			local node = state.tree:get_node()
	-- 			local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)
	-- 			require("easy-dotnet").create_new_item(path, function()
	-- 				require("neo-tree.sources.manager").refresh(state.name)
	-- 			end)
	-- 		end
	-- 	end,
	-- },

	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, Options)
			Options.ensure_installed = Options.ensure_installed or {}
			table.insert(Options.ensure_installed, "omnisharp")
		end,
	},
	{
		"romus204/tree-sitter-manager.nvim",
		optional = true,
		opts = function(_, Options)
			Options.ensure_installed = Options.ensure_installed or {}
			table.insert(Options.ensure_installed, "c_sharp")
			table.insert(Options.ensure_installed, "fsharp")
		end,
	},
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"Issafalcon/neotest-dotnet",
		},
		optional = true,
		---@type neotest.Config | fun(_,neotest.Config)
		---@param NeotestOption neotest.Config
		opts = function(_, NeotestOption)
			NeotestOption = NeotestOption or {}
			NeotestOption.adapters = NeotestOption.adapters or {}
			table.insert(
				NeotestOption.adapters,
				require("neotest-dotnet")({
					dap = {
						adapter_name = "netcoredbg",
					},
				})
			)
		end,
	},
}
