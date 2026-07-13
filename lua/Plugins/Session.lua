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
		opts = function(_,Options)
			require("telescope").load_extension("persisted")
			require("persisted").setup({
                autoload = true
            })
		end,
	},
}
