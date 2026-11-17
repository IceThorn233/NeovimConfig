return {
    {
        "https://github.com/neovim/nvim-lspconfig.git",
    },
    {
        "https://github.com/mason-org/mason-lspconfig.nvim.git",
        opts = {},
    },
    {
        "https://github.com/L3MON4D3/LuaSnip.git",
        opts = function()
            require("luasnip").filetype_extend("c", { "cdoc" })
            require("luasnip").filetype_extend("cpp", { "cppdoc" })
            require("luasnip").filetype_extend("cs", { "csharp", "csharpdoc" })
            require("luasnip").filetype_extend("csharp", { "csharp", "csharpdoc" })
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            require("luasnip.loaders.from_lua").lazy_load()
            vim.api.nvim_create_user_command("LuaSnipReload", function()
                require("luasnip.loaders.from_vscode").load()
                require("luasnip.loaders.from_snipmate").load()
                require("luasnip.loaders.from_lua").load()
            end, { desc = "Reload vscode style snippets." })
            vim.api.nvim_create_user_command("LuaSnipEditSnippets", function()
                require("luasnip.loaders").edit_snippet_files()
            end, {})
        end,
    },
    {
        "https://github.com/onsails/lspkind.nvim.git",
    },
    {
        "https://codeberg.org/mfussenegger/nvim-lint.git",
        opts = {},
        config = function(_, options)
            require("lint").linters_by_ft = options
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "https://github.com/rshkarin/mason-nvim-lint.git",
        opts = {},
    },
}
