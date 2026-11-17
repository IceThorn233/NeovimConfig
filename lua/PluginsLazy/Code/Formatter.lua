return {
    {
        "https://github.com/stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt" },
                cpp = { "clang_format" },
                c = { "clang_format" },
                cs = { "csharpier" },
                sh = { "shfmt" },
                dash = { "shfmt" },
                bash = { "shfmt" },
                json = { "clang_format" },
                zsh = { "shfmt" },
                toml = { "pyproject-fmt", "taplo" },
                cmake = { "cmakefmt" },
                python = { "black" },
            },
        },
        config = function(_, options)
            require("conform").setup(options)
            ---@type conform.FileFormatterConfig
            require("conform").formatters.cmake_format = {
                meta = require("conform.formatters.clang_format").meta,
                command = "cmake-format",
                args = {
                    "--tab-size",
                    "4",
                    "-",
                },
            }
            ---@type conform.FileFormatterConfig
            require("conform").formatters.cmakefmt = {
                meta = {
                    url = "https://cmakefmt.dev/",
                    description = "Automatically format your CMake files — consistent style, zero manual effort.",
                },
                command = "cmakefmt",
                args = {
                    "-",
                    "--stdin-path",
                    "$DIRNAME",
                },
            }
            require("conform").formatters.stylua = {
                args = {
                    "--search-parent-directories",
                    "--respect-ignores",
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    "4",
                    "--stdin-filepath",
                    "$FILENAME",
                    "-",
                },
            }
        end,
    },
}
