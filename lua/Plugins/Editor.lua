local M = {}
---@param globalPluginOptions IceThorn.PluginList
---@return IceThorn.VimPack.Specs
function M.Load(globalPluginOptions)
    ---@type IceThorn.PluginList.Editor
    local PluginOptions = globalPluginOptions.Editor
    ---@type IceThorn.VimPack.Specs
    return {
        {
            Source = { Url = "https://github.com/brenoprata10/nvim-highlight-colors.git" },
            Configura = {
                LazyLoadEvent = "BufEnter",
                Initialization = function()
                    require("nvim-highlight-colors").setup({})
                end,
            },
            Condition = PluginOptions.EnableNVimHighlightColors,
        },
        {
            Source = { Url = "https://github.com/folke/which-key.nvim.git" },
            Condition = PluginOptions.EnableWhichKey,
            Configura = {
                LazyLoadEvent = "BufEnter",
                Initialization = function()
                    require("which-key").setup({
                        preset = "helix",
                        loop = true,
                    })
                end,
            },
        },
        {
            Source = { Url = "https://github.com/nvim-mini/mini.surround.git" },
            Condition = PluginOptions.EnableMiniSurround,
            Configura = {
                LazyLoadEvent = "BufEnter",
                Initialization = function()
                    require("mini.surround").setup({
                        mappings = {
                            add = "<C-c>sa",
                            delete = "<C-c>sd",
                            find = "<C-c>sf",
                            find_left = "<C-c>sF",
                            highlight = "<C-c>sh",
                            replace = "<C-c>sr",
                            update_n_lines = "<C-c>sn",
                        },
                    })
                end,
            },
        },
        {
            Source = { Url = "https://github.com/windwp/nvim-autopairs.git" },
            Condition = PluginOptions.EnableAutoPair,
            Configura = {
                LazyLoadEvent = "BufEnter",
                Initialization = function()
                    require("nvim-autopairs").setup({})
                end,
            },
        },
        {
            Source = { Url = "https://github.com/folke/todo-comments.nvim.git" },
            Condition = PluginOptions.EnableTodoComment,
            Configura = {
                LazyLoadEvent = "BufEnter",
                Initialization = function()
                    require("todo-comments").setup({})
                end,
            },
        },
        {
            Source = { Url = "https://github.com/3rd/image.nvim.git" },
            Condition = PluginOptions.EnableImage,
            Configura = {
                Initialization = function()
                    local backend = "sixel"
                    if os.getenv("TERM") == "xterm-kitty" then
                        backend = "kitty"
                        print("kitty")
                    end
                    require("image").setup({
                        backend = backend, -- kitty / ueberzug / sixel
                        max_height_window_percentage = nil,
                        processor = "magick_cli",
                    })
                end,
                LazyLoadEvent = "BufEnter",
            },
        },
        {
            Source = { Url = "https://github.com/lukas-reineke/indent-blankline.nvim.git" },
            Condition = PluginOptions.EnableIndentBlankline
                and PluginOptions.IndentBlacklinePreset == "IndentBlackline",
            Configura = {
                LazyLoadEvent = {
                    "BufEnter",
                },
                Initialization = function()
                    require("ibl").setup()
                end,
            },
        },
        {
            Source = { Url = "https://github.com/saghen/blink.indent.git" },
            Condition = PluginOptions.EnableIndentBlankline and PluginOptions.IndentBlacklinePreset == "BlinkIndent",
            Configura = {
                Initialization = function()
                    require("blink.indent").setup({})
                end,
                LazyLoadEvent = {
                    "BufEnter",
                },
            },
        },
        {
            Source = "https://github.com/shellRaining/hlchunk.nvim.git",
            Condition = PluginOptions.EnableIndentBlankline and PluginOptions.IndentBlacklinePreset == "Hlchunk",
            Configura = {
                Initialization = function()
                    require("hlchunk").setup({
                        chunk = {
                            enable = true,
                            chars = {
                                ["left_top"] = "┢",
                                ["horizontal_line"] = "━",
                                ["vertical_line"] = "┃",
                                ["left_bottom"] = "┡",
                                ["right_arrow"] = "━",
                            },
                            style = {
                                "#04a5e5",
                            },
                            -- use_treesitter = true,
                        },
                        indent = {
                            enable = true,
                            exclude_filetypes = globalPluginOptions.ExcouldFiletypes,
                            style = {
                                "#ea76cb",
                                "#8839ef",
                                "#d20f39",
                                "#e64553",
                                "#fe640b",
                                "#df8e1d",
                                "#40a02b",
                                "#179299",
                                "#04a5e5",
                                "#209fb5",
                                "#1e66f5",
                                "#7287fd",
                            },
                            -- use_treesitter = true,
                        },
                    })
                end,
                LazyLoadEvent = {
                    "BufEnter",
                },
            },
        },
        {
            Source = "https://github.com/dstein64/nvim-scrollview.git",
            Condition = PluginOptions.EnableScrollView,
            Configura = function()
                require("scrollview").setup({
                    diagnostics_severities = { vim.diagnostic.severity.ERROR },
                })
            end,
        },
        {
            Source = "https://github.com/RRethy/vim-illuminate.git",
            Condition = PluginOptions.EnableIlluminate,
            Configura = function(_)
                require("illuminate").configure({
                    providers = {
                        "lsp",
                        "treesitter",
                        "regex",
                    },
                    delay = 100,
                    filetype_overrides = {},
                })
            end,
        },
        {
            Source = "https://codeberg.org/andyg/leap.nvim.git",
            Condition = PluginOptions.EnableLeap,
            Configura = function()
                require("leap").opts.labels = "asdfghjklqwerzxcvuiopnm"
                require("leap").opts.safe_labels = "asdfghjklqwerzxcvuiopnm"
            end,
        },
        {
            Source = "https://github.com/wsdjeg/bufdel.nvim.git",
        },
    }
end
return M
