local M = {}
---@param globalPluginOptions IceThorn.PluginList
---@return IceThorn.VimPack.Specs
function M.Load(globalPluginOptions)
    local PluginOptions = globalPluginOptions.PackageManager or {}
    ---@type IceThorn.VimPack.Specs
    return {
        {
            Source = { Url = "https://github.com/mason-org/mason.nvim.git" },
            Condition = PluginOptions.EnableMeson,
            Configura = {
                Initialization = function()
                    require("mason").setup({
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
                    })
                end,
            },
        },
        -- {
        --     Source = "https://github.com/jay-babu/mason-nvim-dap.nvim.git",
        --     Condition = PluginOptions.EnableMeson,
        --     Configura = function ()
        --         require("mason-nvim-dap").setup()
        --     end
        -- },
        {
            Source = "https://github.com/mason-org/mason-lspconfig.nvim.git",
            Condition = PluginOptions.EnableMeson,
            Configura = function()
                require("mason-lspconfig").setup({
                    ensure_installed = require("LuaLibrary").List.Merge(
                        PluginOptions.LanguageServerProtocolToInstall or {}
                    ),
                })
            end,
        },
    }
end
return M
