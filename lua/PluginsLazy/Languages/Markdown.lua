return {
    {
        "https://github.com/MeanderingProgrammer/render-markdown.nvim.git",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            file_types = { "markdown", "Avante" },
            completions = { lsp = { enabled = true } },
            latex = { enabled = false },
        },
        ft = { "markdown", "Avante" },
    },
    {
        "https://github.com/techwizrd/render-latex.nvim.git",
        opts = {},
        enabled = os.getenv("TERM") == "xterm-kitty",
    },
    {
        "https://github.com/rshkarin/mason-nvim-lint.git",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, "markdownlint-cli2")
        end,
    },
}
