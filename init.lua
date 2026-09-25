-- vim.pack.add({ "https://github.com/dstein64/vim-startuptime.git", "https://github.com/stevearc/profile.nvim.git" })
-- require("profile").instrument_autocmds()
-- require("profile").start("*")

require("LuaLibrary").Layout.Setup()
require("LuaLibrary").Debug.Setup()
require("Config.Configura")
require("PluginManager").Setup()
local LoadPlugins = require("Config.LoadPlugins")
vim.treesitter.stop()
LoadPlugins.Load({
    Preset = "Default",
    Editor = {
        EnableImage = true,
        EnableIndentBlankline = true,
        IndentBlacklinePreset = "Hlchunk",
        -- IndentBlacklinePreset = "BlinkIndent",
        EnableScrollView = true,
        EnableLeap = true,
        EnableAutoPair = true,
        EnableIlluminate = true,
        EnableNVimHighlightColors = false,
        EnableWhichKey = true,
        EnableMiniSurround = true,
        EnableTodoComment = true,
    },
    FullEditor = {
        EnableTelescopeFzfNative = true,
        EnableTelescope = true,
        EnableBufferLine = false,
        EnableCokeLine = true,
        EnableEdgy = false,
        EnableLayout = false,
        EnableLualine = true,
        EnableNeoTree = true,
    },
    Treesitter = {
        EnableNVimTreesitterTextobject = false,
    },
    LanguageServerProtocol = {
        EnableNVimCmp = false,
        EnableBlinkCmp = true,
        EnableLuaSnip = true,
        EnableFridget = true,
    },
    Themes = {
        EnableCatppuccin = true,
        EnableDashboard = false,
        EnableLiteUi = false,
        EnableDressing = true,
        DashboardPlugin = "AlphaNVim",
    },
})
require("Config.AutoCommands")
require("Config.Keymaps.EmacsKeymap")
require("Config.Keymaps.PluginKeymap")
require("LSPConfigs")
vim.cmd.colorscheme("catppuccin-latte")
vim.cmd.colorscheme("catppuccin-latte")

-- vim.cmd.colorscheme("tokyonight-day")
-- vim.cmd.colorscheme("tokyonight-day")
