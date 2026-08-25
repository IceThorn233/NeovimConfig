return {
	{
		-- https://github.com/stevearc/conform.nvim
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					cpp = { "clang_format" },
					c = { "clang_format" },
					cs = { "csharpier" },
					sh = { "shfmt" },
					dash = { "shfmt" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
					toml = { "pyproject-fmt", "taplo" },
					cmake = { "cmake_format" },
				},
			})
			require("conform").formatters.cmake_format = {
				command = "cmake-format",
				args = {
					"--tab-size",
					"4",
					"-",
				},
			}
		end,
	},
}
