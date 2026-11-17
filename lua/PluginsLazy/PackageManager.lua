---@type LazySpec
return {
    {
        "https://github.com/mason-org/mason.nvim.git",
        dependencies = {},
        opts = {
            log_level = vim.log.levels.OFF,
            pip = {
                install_args = {
                    "-i",
                    "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple",
                },
            },
            npm = {
                install_args = {
                    "--registry=https://registry.npmmirror.com",
                },
            },
            github = {
                download_url_template = "https://github.com/%s/releases/download/%s/%s",
            },
        },
    },
    {
        "https://github.com/rshkarin/mason-nvim-lint.git",
        dependencies = {
            "https://codeberg.org/mfussenegger/nvim-lint.git",
            "https://github.com/mason-org/mason.nvim.git",
        },
        optional = true,
        opts = {},
    },
    {
        "https://github.com/mason-org/mason-lspconfig.nvim.git",
        dependencies = {
            "https://github.com/neovim/nvim-lspconfig.git",
            "https://github.com/mason-org/mason.nvim.git",
        },
        optional = true,
        opts = {},
    },
    {
        "https://github.com/jay-babu/mason-nvim-dap.nvim.git",
        dependencies = {
            "https://codeberg.org/mfussenegger/nvim-dap.git",
            "https://github.com/mason-org/mason.nvim.git",
        },
        optional = true,
    },
}
