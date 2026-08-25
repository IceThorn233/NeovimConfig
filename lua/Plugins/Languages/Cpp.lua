---@type LazySpec
return {
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = function(_, _)
			require("lint").linters_by_ft.cmake = { "cmakelint" }
		end,
	},
	{
		"danymat/neogen",
		opts = {
			snippet_engine = "luasnip",
		},
	},
	-- {
	-- 	"mason-org/mason.nvim",
	-- 	optional = true,
	-- 	opts = function(_, Options)
	-- 		Options.ensure_installed = Options.ensure_installed or {}
	-- 		table.insert(Options.ensure_installed, "")
	-- 	end,
	-- },
	{
		"jay-babu/mason-nvim-dap.nvim",
		optional = true,
		opts = function(_, Options)
			Options.ensure_installed = Options.ensure_installed or {}
			table.insert(Options.ensure_installed, "codelldb")
		end,
	},
	-- {
	-- 	"mason-org/mason-lspconfig.nvim",
	-- 	optional = true,
	-- 	opts = function(_, Options)
	-- 		Options.ensure_installed = Options.ensure_installed or {}
	-- 		table.insert(Options.ensure_installed, "ccls")
	-- 	end,
	-- },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"orjangj/neotest-ctest",
		},
		optional = true,
		---@type neotest.Config | fun(_,neotest.Config)
		---@param NeotestOption neotest.Config
		opts = function(_, NeotestOption)
			NeotestOption = NeotestOption or {}
			NeotestOption.adapters = NeotestOption.adapters or {}
			table.insert(
				NeotestOption.adapters,
				require("neotest-ctest").setup({
					root = function(RootDirectory)
						return require("neotest.lib").files.match_root_pattern(
							"CMakePresets.json",
							"CMakeUserPresets.json",
							"CMakeLists.txt",
							".cache",
							".clangd",
							".ccls",
							".vscode",
							".zed",
							"build",
							"out",
							".git"
						)(RootDirectory)
					end,
				})
			)
		end,
	},
	{
		"Blackcyan30/nvim-doccomment-tags",
		config = function()
			require("nvim-doccomment-tags.doccomment-tags").setup({
				tags = {
					"@param",
					"@return",
					"@brief",
					"@file",
					"@author",
					"@version",
					"@see",
					"@since",
					"@details",
					"@throws",
					"@exception",
					"@deprecated",
					"@todo",
					"@note",
					"@warning",
					"@bug",
					"@example",
					"@test",
					"@def",
					"@typedef",
					"@var",
					"@struct",
					"@class",
					"@enum",
					"@interface",
					"@package",
					"@namespace",
					"@ingroup",
					"@addtogroup",
					"@fn",
					"@name",
					"@code",
					"@endcode",
					"@sa",
					"@ref",
					"@link",
					"@endlink",
					"@copydoc",
					"@docRoot",
					"@inheritDoc",
					"@internal",
					"@invariant",
					"@mainpage",
					"@page",
					"@section",
					"@subsection",
					"@test",
					"@threadsafe",
					"@nosubgrouping",
					"@param",
					"@return",
					"@returns",
					"@date",
					"@namespace",
					"@example",
					"@exception",
					"@warning",
					"@since",
					"@todo",
					"@author",
					"@authors",
					"@brief",
					"@file",
					"@anchor",
                    "@result",
                    "@retval",
					"@note", -- Add or remove tags as needed
				},
			})
		end,
	},
}
