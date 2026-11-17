-- vim.pack.add({ "https://github.com/dstein63/vim-startuptime.git", "https://github.com/stevearc/profile.nvim.git" })
-- require("profile").instrument_autocmds()
-- require("profile").start("*")
require("LuaLibrary").Layout.Setup()
require("PluginManager").Setup()
require("Config.Configura")
vim.pack.add({ "https://github.com/folke/lazy.nvim.git" })
require("lazy").setup({
    spec = {
        { import = "PluginsLazy.Editor" },
        { import = "PluginsLazy.PackageManager" },
        { import = "PluginsLazy.Treesitter" },
        { import = "PluginsLazy.Themes" },
        { import = "PluginsLazy.Code.Formatter" },
        { import = "PluginsLazy.Code.Task" },
        { import = "PluginsLazy.Languages.Cpp" },
        { import = "PluginsLazy.Languages.Markdown" },
        { import = "PluginsLazy.LanguageServerProtocol.Lsp" },
        { import = "PluginsLazy.LanguageServerProtocol.BlinkCmp" },
    },
})
require("Config.AutoCommands")
require("Config.Keymaps.EmacsKeymap")
require("Config.Keymaps.PluginKeymap")
require("LSPConfigs")
vim.cmd.colorscheme("catppuccin-latte")
vim.cmd.colorscheme("catppuccin-latte")
