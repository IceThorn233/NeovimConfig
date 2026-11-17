return {
    {
        "https://github.com/nvim-treesitter/nvim-treesitter.git",
        opts = {},
    },
    {
        "https://github.com/JoosepAlviste/nvim-ts-context-commentstring.git",
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "https://github.com/HiPhish/rainbow-delimiters.nvim.git",
        opts = {
            strategy = {},
            query = {},
            highlight = {},
        },
        config = function(_, options)
            require("rainbow-delimiters.setup").setup(options)
        end,
    },
    {
        "https://github.com/folke/ts-comments.nvim.git",
        enabled = false,
        opts = {},
    },
    {
        "https://github.com/windwp/nvim-ts-autotag.git",
        opts = {},
    },
}
