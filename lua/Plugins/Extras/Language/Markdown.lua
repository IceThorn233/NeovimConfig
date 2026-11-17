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
                    latex = { enabled = false },
                })
            end,
        },
        {
            Source = "https://github.com/techwizrd/render-latex.nvim.git",
            Condition = os.getenv("TERM") == "xterm-kitty" and pluginOptions.EnableMarkdown,
            Configura = function()
                require("render_latex").setup({
                    -- render = {
                    --     preset = "match_text", -- "compact" or "presentation"
                    --     inline = "conceal", -- "content", "highlight", or false
                    --     inline_symbols = true,
                    --     live_preview = true,
                    --     hide_on_cmdline = false,
                    -- },
                })
            end,
        },
        {
            Source = "https://github.com/rshkarin/mason-nvim-lint.git",
            Overwrite = {
                ensure_installed = { "markdownlint-cli2" },
            },
        },
    }
end
return M
