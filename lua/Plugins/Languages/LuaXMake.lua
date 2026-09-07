return {
	{
		"Mythos-404/xmake.nvim",
		version = "^3",
		lazy = true,
		event = "BufReadPost",
		opts = {
			on_save = {
				reload_project_info = false,
				lsp_compile_commands = {
					enable = false,
					output_dir = "build",
				},
			},
		},
	},
}
