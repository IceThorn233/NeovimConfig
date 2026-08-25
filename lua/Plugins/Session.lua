return {
	-- {
	-- 	"gennaro-tedesco/nvim-possession",
	-- 	dependencies = {
	-- 		"ibhagwan/fzf-lua",
	-- 	},
	-- 	opts = function()
	-- 		require("nvim-possession").setup({})
	-- 		vim.api.nvim_create_user_command(
	-- 			"PossessionList",
	-- 			require("nvim-possession").list,
	-- 			{ desc = "📌list sessions" }
	-- 		)
	-- 		vim.api.nvim_create_user_command(
	-- 			"PossessionNew",
	-- 			require("nvim-possession").new,
	-- 			{ desc = "📌create new session" }
	-- 		)
	-- 		vim.api.nvim_create_user_command(
	-- 			"PossessionUpdate",
	-- 			require("nvim-possession").update,
	-- 			{ desc = "📌update current session" }
	-- 		)
	--            vim.api.nvim_create_user_command(
	--                "PossessionDelete",
	--                require("nvim-possession").delete,
	--                {desc="📌delete selected session"}
	--            )
	-- 	end,
	-- },
	-- Lua
	{
		"olimorris/persisted.nvim",
		event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
				optional = true,
			},
		},
		lazy = false,
		opts = {
			autostart = false,
			should_save = function()
				if
					vim.bo.filetype == "aplha"
					or vim.bo.filetype == "trouble"
					or vim.bo.filetype == "toggleterm"
					or vim.bo.filetype == "grug-far"
					or vim.bo.filetype == "neo-tree"
					or vim.bo.filetype == "checkhealth"
					or vim.bo.filetype == "help"
					or vim.bo.filetype == "better_term"
					or vim.bo.filetype == "dapui_scopes"
					or vim.bo.filetype == "dapui_breakpoints"
					or vim.bo.filetype == "dapui_stacks"
					or vim.bo.filetype == "dapui_watches"
					or vim.bo.filetype == "dapui_console"
					or vim.bo.filetype == "dap-repl"
					or vim.bo.filetype == "dap-view"
					or vim.bo.filetype == "grug-far"
					or vim.bo.filetype == "OverseerList"
					or vim.bo.filetype == "OverseerOutput"
				then
					return false
				end
				return true
			end,
		},
		config = function(_, Options)
			require("telescope").load_extension("persisted")
			require("persisted").setup(Options)
			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistedLoadPost",
				callback = function(Session)
					if pcall(require, "neo-tree") then
						vim.cmd.Neotree("show")
					end
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistedLoadPre",
				callback = function(Session)
					if pcall(require, "bufferline") then
						vim.cmd.BufferLineCloseOthers()
						if pcall(require, "bufdel") then
							vim.cmd.Bdelete()
						else
							vim.cmd.bdelete()
						end
					end
				end,
			})
		end,
	},
}
