--- @type LazyConfig
return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        lazy = false,
        keys = {},
    },
    {
        "echasnovski/mini.pairs",
        version = "*",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "dstein64/nvim-scrollview",
        opts = {},
    },
    {
        "Pocco81/auto-save.nvim",
        opts = {},
    },
    {
        "3rd/image.nvim",
        dependencies = {},
        opts = {
            backend = "sixel", -- kitty / ueberzug / sixel
            max_height_window_percentage = nil,
        },
        -- version = "v1.5.1"
    },
    {
        "mrjones2014/smart-splits.nvim",
        opts = {
            -- Ignored buffer types (only while resizing)
            ignored_buftypes = {
                "nofile",
                "quickfix",
                "prompt",
            },
            ignored_filetypes = {},
            default_amount = 3,
            at_edge = "wrap",
            float_win_behavior = "previous",
            move_cursor_same_row = false,
            cursor_follows_swapped_bufs = false,
            ignored_events = {
                "BufEnter",
                "WinEnter",
            },
            multiplexer_integration = nil,
            disable_multiplexer_nav_when_zoomed = true,
            kitty_password = nil,
            zellij_move_focus_or_tab = false,
        },
        keys = {
            {
                "<C-S-H>",
                "<CMD>lua require('smart-splits').resize_left()<CR>",
            },
            {
                "<C-S-J>",
                "<CMD>lua require('smart-splits').resize_down()<CR>",
            },
            {
                "<C-S-K>",
                "<CMD>lua require('smart-splits').resize_up()<CR>",
            },
            {
                "<C-S-L>",
                "<CMD>lua require('smart-splits').resize_right()<CR>",
            },
            {
                "<C-h>",
                "<CMD>lua require('smart-splits').move_cursor_left()<CR>",
            },
            {
                "<C-j>",
                "<CMD>lua require('smart-splits').move_cursor_down()<CR>",
            },
            {
                "<C-k>",
                "<CMD>lua require('smart-splits').move_cursor_up()<CR>",
            },
            {
                "<C-l>",
                "<CMD>lua require('smart-splits').move_cursor_right()<CR>",
            },
        },
    },
    {
    	"saghen/blink.indent",
    	--- @module 'blink.indent'
    	--- @type blink.indent.Config
    	opts = {},
    },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     main = "ibl",
    --     ---@module "ibl"
    --     ---@type ibl.config
    --     opts = {
    --         scope = {
    --             enabled = true
    --         }
    --     },
    -- },
    {
        "nvim-mini/mini.surround",
        version = "*",
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
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            loop = true,
        },
        keys = {
            {
                "<leader>?",
                '<CMD>lua require("which-key").show({ global = false })<CR>',
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    -- {
    -- 	"NyxVim/nvim-colorizer.lua",
    -- 	opts = {},
    -- 	lazy = false,
    -- },
    {
        "brenoprata10/nvim-highlight-colors",
        opts = {},
    },
}
