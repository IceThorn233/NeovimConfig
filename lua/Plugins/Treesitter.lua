--- @type LazySpec
return {
    {
        "hiphish/rainbow-delimiters.nvim",
        dependencies = {},
        config = function()
            ---@type rainbow_delimiters.config
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = "rainbow-delimiters.strategy.global",
                    vim = "rainbow-delimiters.strategy.local",
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                priority = {
                    [""] = 110,
                    lua = 210,
                },
                highlight = {
                    "RainbowDelimiterRed",
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
            multiwindow = false, -- Enable multiwindow support.
            max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },
    },
    {
        "windwp/nvim-ts-autotag",
        lazy = false,
        opts = {
            ---@type nvim-ts-autotag.Opts
            opts = {
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = true, -- Auto close on trailing </
            },
        },
        ---@type fun(table,nvim-ts-autotag.FiletypeConfig)
        config = function(_, Option)
            require("nvim-ts-autotag").setup({ Option })
        end,
    },
    {
        "romus204/tree-sitter-manager.nvim",
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
        opts = {
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "markdown",
                "markdown_inline",
                "rust",
                -- "javascript",
                "java",
                "cmake",
                "cpp",
                "html",
                "zon",
                "zig",
                "latex",
                "yaml",
            },
            auto_install = false,
            highlight = true,
            languages = {},
        },
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        ---@type ts_context_commentstring.Config
        opts = {
            enable_autocmd = true,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        --- @type TSTextObjects.UserConfig
        opts = {
            select = {
                enable = true,
                lookahead = true,
            },
            move = {
                enable = true,
                set_jumps = true,
            },
        },
        --- @type fun(table,TSTextObjects.UserConfig)
        --- @param Option TSTextObjects.UserConfig
        config = function(_, Option)
            require("nvim-treesitter-textobjects").setup(Option)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        -- ---@type TSConfig
        -- opts = {
        --     install_dir = ''
        -- },
        ---@param TreesitterOption TSConfig
        config = function(_, TreesitterOption)
            vim.o.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            require("nvim-treesitter").setup(TreesitterOption)
        end,
    },
}
