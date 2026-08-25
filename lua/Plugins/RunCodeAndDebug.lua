---@type LazySpec
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"jbyuki/one-small-step-for-vimkind",
		},
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		end,
		keys = {},
	},
	{
		"igorlfs/nvim-dap-view",
        lazy = false,
		---@module 'dap-view'
		---@type dapview.Config
		opts = {
			auto_toggle = true,
		},
	},
	-- virtual text for the debugger
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		opts = {},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = "mason.nvim",
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"codelldb",
			},
		},
	},
	{
		"stevearc/overseer.nvim",
		---@module 'overseer'
		---@type overseer.SetupOpts
		opts = {},
	},
	{
		"nvim-neotest/neotest",
		optional = true,
        dependencies = {
            "stevearc/overseer.nvim",
        },
		opts = function(_, opts)
			opts = opts or {}
			opts.consumers = opts.consumers or {}
			opts.consumers.overseer = require("neotest.consumers.overseer")
		end,
	},
}
