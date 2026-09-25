local M = {}
---@param globalPluginOptions IceThorn.PluginList
---@return IceThorn.VimPack.Specs
M.Load = function(globalPluginOptions)
    local PluginOptions = globalPluginOptions.Treesitter or {}
    ---@type IceThorn.VimPack.Specs
    return {
        {
            Source = "https://github.com/nvim-treesitter/nvim-treesitter.git",
            Condition = PluginOptions.EnableNVimTreesitter,
            Configura = function()
                require("nvim-treesitter").setup({})
            end,
        },
        {
            Source = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring.git",
            Condition = PluginOptions.EnableNVimTsCommentstring
                and PluginOptions.NVimTsCommentStringPreset == "NvimTsContextCommentstring",
            Configura = function()
                require("ts_context_commentstring").setup({
                    enable_autocmd = false,
                })
            end,
        },
        {
            Source = "https://github.com/folke/ts-comments.nvim.git",
            Condition = PluginOptions.EnableNVimTsCommentstring
                and PluginOptions.NVimTsCommentStringPreset == "TsComment",
            Configura = function()
                require("ts-comments").setup({})
            end,
        },
        {
            Source = "https://github.com/HiPhish/rainbow-delimiters.nvim.git",
            Configura = function()
                require("rainbow-delimiters.setup").setup({
                    strategy = {},
                    query = {},
                    highlight = {},
                })
            end,
        },
        {
            Source = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git",
            Condition = PluginOptions.EnableNVimTreesitterTextobject,
            Configura = function(_)
                require("nvim-treesitter-textobjects").setup()
            end,
        },
        -- {
        --     Source = "https://github.com/windwp/nvim-ts-autotag.git",
        -- },
    }
end
return M
