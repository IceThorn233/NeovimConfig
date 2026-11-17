local M = {}
---@param GlobalPluginOptions IceThorn.PluginList
---@return IceThorn.VimPack.Specs
function M.Load(GlobalPluginOptions)
    local PluginOptions = GlobalPluginOptions.Formatter
    ---@type IceThorn.VimPack.Specs
    return {
        {
            Source = { Url = "https://github.com/stevearc/conform.nvim" },
            Condition = PluginOptions.EnableConform,
            Configura = {
                Initialization = function(overwrite)
                    require("conform").setup(require("LuaLibrary").Table.TableDeepExtend("Force", {
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
                    }, overwrite or {}))
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
        },
    }
end
return M
