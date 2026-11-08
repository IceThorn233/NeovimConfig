local M = {}
---@return IceThorn.VimPack.Specs
---@param globalPluginOptions IceThorn.PluginList
M.Load = function(globalPluginOptions)
    local pluginOptions = globalPluginOptions.Extras or {}
    ---@type IceThorn.VimPack.Specs
    return {
        {
            Source = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git",
            Condition = pluginOptions.EnableMarkdown,
            Configura = function()
                require("render-markdown").setup({
                    completions = { lsp = { enabled = true } },
                })
            end,
        },
    }
end
return M
