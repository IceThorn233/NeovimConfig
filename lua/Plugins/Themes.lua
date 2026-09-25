local M = {}
---@param globalPluginOptions IceThorn.PluginList
---@return IceThorn.VimPack.Specs
function M.Load(globalPluginOptions)
    local PluginOptions = globalPluginOptions.Themes or {}
    ---@type IceThorn.VimPack.Specs
    return {
        {
            Source = "https://github.com/catppuccin/nvim.git",
            Name = "catppuccin",
            Condition = PluginOptions.EnableCatppuccin,
            Configura = function()
                require("catppuccin").setup({
                    flavour = "latte",
                    background = {
                        light = "latte",
                        dark = "macchiato",
                    },
                    term_colors = true,
                    lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                            ok = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                            ok = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    integrations = {
                        cmp = true,
                        alpha = true,
                        blink_cmp = {
                            style = "bordered",
                        },
                        blink_indent = true,
                        diffview = true,
                        dropbar = true,
                        fzf = true,
                        gitsigns = true,
                        grug_far = true,
                        neotree = true,
                        leap = true,
                        neotest = true,
                        neogit = true,
                        dap = true,
                        telescope = true,
                        lsp_trouble = true,
                        which_key = true,
                        illuminate = true,
                    },
                })
            end,
        },
        {
            Source = "https://github.com/shrey99sh/lite-ui.git",
            Condition = PluginOptions.EnableLiteUi and not PluginOptions.EnableDressing,
            Configura = function()
                require("lite-ui").setup({
                    theme = "catppuccin", -- see themes below

                    input = {
                        relative = "cursor", -- "cursor" or "editor"
                        border = "rounded",
                        auto_detect_cword = true, -- prefills symbol name for LSP rename
                    },

                    select = {
                        relative = "editor",
                        border = "rounded",
                        show_numbers = true,
                    },
                })
            end,
        },
        {
            Source = "https://github.com/stevearc/dressing.nvim.git",
            Condition = PluginOptions.EnableDressing and not PluginOptions.EnableLiteUi,
            Configura = function()
                require("dressing").setup({
                    input = {
                        -- Set to false to disable the vim.ui.input implementation
                        enabled = true,

                        -- Default prompt string
                        default_prompt = "Input",

                        -- Trim trailing `:` from prompt
                        trim_prompt = true,

                        -- Can be 'left', 'right', or 'center'
                        title_pos = "left",

                        -- The initial mode when the window opens (insert|normal|visual|select).
                        start_mode = "insert",

                        -- These are passed to nvim_open_win
                        border = "rounded",
                        -- 'editor' and 'win' will default to being centered
                        relative = "cursor",

                        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                        prefer_width = 40,
                        width = nil,
                        -- min_width and max_width can be a list of mixed types.
                        -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
                        max_width = { 140, 0.9 },
                        min_width = { 20, 0.2 },

                        buf_options = {},
                        win_options = {
                            -- Disable line wrapping
                            wrap = false,
                            -- Indicator for when text exceeds window
                            list = true,
                            listchars = "precedes:…,extends:…",
                            -- Increase this for more context when text scrolls off the window
                            sidescrolloff = 0,
                        },

                        -- Set to `false` to disable
                        mappings = {
                            n = {
                                ["<Esc>"] = "Close",
                                ["<CR>"] = "Confirm",
                            },
                            i = {
                                ["<C-c>"] = "Close",
                                ["<CR>"] = "Confirm",
                                ["<Up>"] = "HistoryPrev",
                                ["<Down>"] = "HistoryNext",
                            },
                        },
                    },
                    select = {
                        -- Set to false to disable the vim.ui.select implementation
                        enabled = true,

                        -- Priority list of preferred vim.select implementations
                        backend = { "nui", "builtin" },

                        nui = {
                            position = "50%",
                            size = nil,
                            relative = "editor",
                            border = {
                                style = "rounded",
                            },
                            buf_options = {
                                swapfile = false,
                                filetype = "DressingSelect",
                            },
                            win_options = {
                                winblend = 0,
                            },
                            max_width = 80,
                            max_height = 40,
                            min_width = 40,
                            min_height = 10,
                        },
                        -- Used to override format_item. See :help dressing-format
                        format_item_override = {},

                        -- see :help dressing_get_config
                        get_config = nil,
                    },
                })
            end,
        },
        {
            Source = "https://github.com/Kurama622/profile.nvim.git",
            Condition = PluginOptions.EnableDashboard and PluginOptions.DashboardPlugin == "ProfileNVim",
            Configura = function()
                require("profile").setup({
                    avatar_path = vim.fn.stdpath("config") .. "/Asserts/ᴘʟᴀɴᴇᴛ ᴄᴀꜰᴇ 🪐🐈_⬛.jpg",
                })
            end,
        },
    }
end

return M
