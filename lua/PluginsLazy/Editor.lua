---@type LazySpec
return {
    {
        "https://github.com/dstein64/nvim-scrollview.git",
        lazy = true,
        event = { "BufEnter" },
        opts = {
            diagnostics_severities = { vim.diagnostic.severity.ERROR },
        },
    },
    {
        "https://github.com/shrey99sh/lite-ui.git",
        lazy = false,
        opts = {
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
        },
    },
    {
        "CRAG666/betterTerm.nvim",
        opts = {
            -- your options
        },
    },
    {
        "https://github.com/brenoprata10/nvim-highlight-colors.git",
        envnt = "BufEnter",
        lazy = true,
        opts = {},
    },
    {
        "https://github.com/folke/which-key.nvim.git",
        lazy = false,
        opts = {
            preset = "helix",
            loop = true,
        },
    },
    {
        "https://github.com/nvim-mini/mini.surround.git",
        lazy = false,
        opts = {
            mappings = {
                add = "<C-c>sa",
                delete = "<C-c>sd",
                find = "<C-c>sf",
                find_left = "<C-c>sF",
                highlight = "<C-c>sh",
                replace = "<C-c>sr",
                update_n_lines = "<C-c>sn",
            },
        },
        config = function(_, options)
            require("mini.surround").setup(options)
        end,
    },
    {
        "https://github.com/windwp/nvim-autopairs.git",
        lazy = true,
        event = "BufEnter",
        opts = {},
    },
    {
        "https://github.com/folke/todo-comments.nvim.git",
        lazy = true,
        event = "BufEnter",
        opts = {},
    },
    {
        "https://github.com/3rd/image.nvim.git",
        lazy = true,
        event = "BufEnter",
        build = false,
        opts = {
            max_height_window_percentage = nil,
            processor = "magick_cli",
        },
    },
    {
        "https://github.com/3rd/image.nvim.git",
        lazy = true,
        event = "BufEnter",
        opts = function(_, options)
            options = options or {}
            if os.getenv("TERM") == "xterm-kitty" then
                options.backend = "kitty"
            else
                options.backend = "sixel"
            end
        end,
    },
    {
        "https://github.com/lukas-reineke/indent-blankline.nvim.git",
        event = "BufEnter",
        lazy = true,
        enabled = false,
        opts = {},
    },
    {
        "saghen/blink.indent",
        --- @module 'blink.indent'
        --- @type blink.indent.Config
        opts = {},
        config = function(_, opts)
            require("blink.indent").setup(opts)
        end,
        enabled = false,
    },
    {
        "https://github.com/shellRaining/hlchunk.nvim.git",
        event = "BufEnter",
        lazy = true,
        enabled = true,
        opts = {
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
        },
    },
    {
        "https://github.com/RRethy/vim-illuminate.git",
        opts = {
            providers = {
                "lsp",
                "treesitter",
                "regex",
            },
            delay = 100,
            filetype_overrides = {},
        },
        config = function(_, options)
            -- default configuration
            require("illuminate").configure(options)
        end,
    },
    {
        "https://codeberg.org/andyg/leap.nvim.git",
        config = function(_, _)
            require("leap").opts.labels = "asdfghjklqwerzxcvuiopnm"
            require("leap").opts.safe_labels = "asdfghjklqwerzxcvuiopnm"
        end,
    },
    "https://github.com/wsdjeg/bufdel.nvim.git",
    {
        "https://github.com/nvim-neo-tree/neo-tree.nvim.git",
        branch = "v3.x",
        dependencies = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/MunifTanjim/nui.nvim",
            "https://github.com/nvim-tree/nvim-web-devicons",
        },
        lazy = true,
        opts = {
            source_selector = {
                winbar = true,
                statusline = true,
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    never_show = {
                        ".DS_store",
                    },
                },
                window = {
                    mappings = {
                        ["<TAB>"] = { "toggle_node", nowait = true },
                        ["l"] = { "open", nowait = false },
                        ["h"] = { "close_node", nowait = true },
                    },
                },
                commands = {},
            },
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols",
            },
            clipboard = {
                sync = "global",
            },
        },
    },
    {
        "https://github.com/nvim-lualine/lualine.nvim.git",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "catppuccin-nvim",
            },
        },
    },
    {
        "https://github.com/akinsho/bufferline.nvim.git",
        dependencies = {
            "https://github.com/catppuccin/nvim.git",
        },
        enabled = true,
        opts = function(_, opts)
            opts.highlights = require("catppuccin.special.bufferline").get_theme()
        end,
    },
    {
        "https://github.com/akinsho/bufferline.nvim.git",
        ---@type bufferline.UserConfig
        opts = {
            options = {
                right_mouse_command = nil,
                -- middle_mouse_command = "Bdelete! %d",
                -- close_command = "Bdelete! %d",
                separator_style = "padded_slant",
                tab_size = 10,
                max_name_length = 20,
                indicator = {
                    style = "underline",
                },
                custom_filter = function(bufferName, _)
                    for _, excludeFiletype in ipairs(require("Config.ExcludeFiletypes")) do
                        if vim.bo[bufferName].filetype == excludeFiletype then
                            return false
                        end
                    end
                    return true
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "FILE EXPLORER",
                        separator = true,
                    },
                    {
                        filetype = "grug-far",
                        text = "SEARCH AND REPLACE",
                        separator = true,
                    },
                },
                -- numbers = function(opts)
                --     return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
                -- end,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level)
                    return " " .. (level:match("error") and " " or " ") .. count
                end,
                pick = {
                    alphabet = "asdf3740ghjkl",
                },
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
            },
        },
    },
    {
        "https://github.com/nvim-zh/colorful-winsep.nvim.git",
        config = true,
        event = { "WinLeave" },
    },
    {
        "https://github.com/Bekaboo/dropbar.nvim.git",
        opts = {},
    },
    {
        "https://github.com/MagicDuck/grug-far.nvim.git",
        opts = {
            headerMaxWidth = 80,
        },
    },
    {
        "https://github.com/folke/edgy.nvim.git",
        enabled = true,
        opts = {
            left = {},
            ---@type (Edgy.View.Opts|string)[]
            bottom = {
                {
                    title = "BetterTerm Terminal",
                    ft = "better_term",
                },
                {
                    title = "CMake task",
                    ft = "cmake_tools_terminal",
                },
                {
                    title = "Toggleterm Terminal",
                    ft = "toggleterm",
                    open = "ToggleTerm",
                },
                {
                    title = "Task List",
                    ft = "OverseerList",
                    open = "OverseerOpen",
                },
                {
                    title = "Task Console",
                    ft = "OverseerOutput",
                    open = "OverseerOpen",
                },
                {
                    title = "Trouble",
                    ft = "trouble",
                    open = "Trouble diagnostics toggle auto_close=false auto_jump=true focus=true",
                },
                {
                    title = "DapView",
                    ft = "dap-view",
                    open = "DapViewToggle",
                },
                {
                    title = "DapView",
                    ft = "dap-view-term",
                    open = "DapViewToggle",
                },
                {
                    title = "DapRepl",
                    ft = "dap-repl",
                    open = "DapViewToggle",
                },
            },
            ---@type (Edgy.View.Opts|string)[]
            right = {
                {
                    title = "Find And Replace",
                    ft = "grug-far",
                    open = "GrugFar",
                    size = { width = 0.3 },
                },
                {
                    title = "Neo-Tree Symbols",
                    ft = "neo-tree",
                    open = "Neotree source=document_symbols position=right",
                    filter = function(BufferName)
                        return vim.b[BufferName].neo_tree_source == "document_symbols"
                    end,
                },
                {
                    title = "Neo-Tree",
                    ft = "neo-tree",
                    open = "Neotree source=filesystem position=right",
                    filter = function(BufferName)
                        return vim.b[BufferName].neo_tree_source == "filesystem"
                    end,
                },
            },
            top = {},
            ---@type vim.wo
            wo = {
                winbar = false,
                spell = false,
            },
            animate = {
                enabled = false,
                fps = 60,
                cps = 60,
            },
            ---@type table<Edgy.Pos, {size:integer | fun():integer, wo:vim.wo}>
            options = {
                left = { size = 40 },
                bottom = { size = 17 },
                right = { size = 40 },
                top = { size = 10 },
            },
            keys = {
                ["<C-RIGHT>"] = function(win)
                    win:resize("width", 2)
                end,
                ["<C-LEFT>"] = function(win)
                    win:resize("width", -2)
                end,
                ["<C-UP>"] = function(win)
                    win:resize("height", 2)
                end,
                ["<C-DOWN>"] = function(win)
                    win:resize("height", -2)
                end,
            },
        },
    },
    {
        "https://github.com/nvim-telescope/telescope.nvim.git",
        dependencies = {
            {
                "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release "
                    .. "&&"
                    .. " cmake --build build --config Release --target install",
            },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<A-j>"] = "move_selection_next",
                        ["<A-k>"] = "move_selection_previous",
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
                },
            },
        },
        config = function(_, options)
            require("telescope").setup(options)
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "https://codeberg.org/gi1242/nvim-autosave.git",
        opts = {
            timeout = 0, -- miliseconds
            verbose = true,
            enabled_on_startup = true,
            notify = vim.notify,
        },
    },
    {
        "https://github.com/stevearc/resession.nvim.git",
        opts = {
            autosave = {
                enabled = false,
                interval = 60,
                notify = true,
            },
            extensions = {
                quickfix = {},
                dap = {},
                colorscheme = {},
            },
        },
    },
    {
        "https://github.com/folke/trouble.nvim.git",
        opts = {},
    },
    {
        "https://github.com/nvim-telescope/telescope.nvim.git",
        dependencies = {
            "https://github.com/scottmckendry/pick-resession.nvim.git",
            "https://github.com/stevearc/resession.nvim.git",
        },
        opts = {
            extensions = {
                resession = {
                    prompt_title = "Find Sessions", -- telescope prompt title
                    dir = "session", -- directory where resession stores sessions
                    layout = nil, -- telescope picker layout, defaults to dropdown if not set
                },
            },
        },
    },
}
