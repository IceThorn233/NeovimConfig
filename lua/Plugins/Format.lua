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
                    cmake = { "cmakefmt" },
                    python = { "black" }
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
            ---@type conform.FileFormatterConfig
            require("conform").formatters.cmakefmt = {
                meta = {
                    url = "https://cmakefmt.dev/",
                    description = "Automatically format your CMake files — consistent style, zero manual effort.",
                },
                command = "cmakefmt",
                args = {
                    "$FILENAME",
                },
            }
        end,
    },
}
