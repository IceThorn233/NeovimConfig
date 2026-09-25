local M = {}
---@return IceThorn.VimPack.Specs
---@param globalPluginOptions IceThorn.PluginList
M.Load = function(globalPluginOptions)
    if (globalPluginOptions.Extras or {}).EnableCAndCpp then
        globalPluginOptions
            .PackageManager--[[@cast-?]]
            .LanguageServerProtocolToInstall =
            require("LuaLibrary").List.Merge(
                ((globalPluginOptions or {}).PackageManager or {}).LanguageServerProtocolToInstall or {},
                { "lua_ls", "neocmake", "clice" }
            )
        ---@type IceThorn.VimPack.Specs
        return {
            {
                Source = "https://github.com/Mythos-404/xmake.nvim.git",
                Configura = function()
                    require("xmake").setup({})
                end,
            },
            {
                Source = "https://github.com/Civitasv/cmake-tools.nvim.git",
                Configura = function()
                    local osys = require("cmake-tools.osys")
                    require("cmake-tools").setup({
                        cmake_command = "cmake", -- this is used to specify cmake command path
                        ctest_command = "ctest", -- this is used to specify ctest command path
                        ctest_show_labels = false, -- also show labels in the test picker
                        cmake_use_preset = true,
                        cmake_regenerate_on_save = false, -- auto generate when save CMakeLists.txt
                        cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
                        cmake_build_directory = function()
                            return "build"
                        end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
                    })
                end,
            },
        }
    end
    return {}
end
return M
