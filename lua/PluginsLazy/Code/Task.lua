---@type LazySpec
return {
    {
        "https://codeberg.org/mfussenegger/nvim-dap.git",
        config = function()
            require("DAPConfigs")
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
            )
            vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
        end,
    },
    {
        "https://github.com/igorlfs/nvim-dap-view.git",
        opts = {
            winbar = {
                show = true,
                -- You can add a "console" section to merge the terminal with the other views
                sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl", "console" },
                default_section = "watches",
                -- Append hints with keymaps within the labels
                show_keymap_hints = true,
                -- List of up to 2 strings, defining left and right separators
                separators = nil,
                -- Configure each section individually
                base_sections = {
                    -- Labels can be set dynamically with functions
                    -- Each function receives the window's width and the current section as arguments
                    breakpoints = { label = "Breakpoints", keymap = "B" },
                    scopes = { label = "Scopes", keymap = "S" },
                    exceptions = { label = "Exceptions", keymap = "E" },
                    watches = { label = "Watches", keymap = "W" },
                    threads = { label = "Threads", keymap = "T" },
                    repl = { label = "REPL", keymap = "R" },
                    sessions = { label = "Sessions", keymap = "K" },
                    console = { label = "Console", keymap = "C" },
                },
                custom_sections = {},
                controls = {
                    enabled = true,
                    position = "right",
                    buttons = {
                        "play",
                        "step_into",
                        "step_over",
                        "step_out",
                        "step_back",
                        "run_last",
                        "terminate",
                        "disconnect",
                    },
                    custom_buttons = {},
                },
            },
            auto_toggle = true,
            virtual_text = {
                enabled = true,
            },
        },
    },
    {
        "https://github.com/stevearc/resession.nvim.git",
        optional = true,
        dependencies = {
            "https://github.com/stevearc/overseer.nvim.git",
        },
        opts = function(_, opts)
            opts.extensions = opts.extensions or {}
            opts.extensions["overseer"] = {
                autostart_on_load = true,
            }
        end,
    },
    {
        "https://github.com/jay-babu/mason-nvim-dap.nvim.git",
        opts = {},
    },
    {
        "https://github.com/nvim-neotest/neotest.git",
        lazy = false,
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        ---@type neotest.Config
        opts = {
            log_level = vim.log.levels.OFF,
        },
    },
    {
        "https://github.com/stevearc/overseer.nvim.git",
        opts = {},
    },
    {
        "https://github.com/stevearc/overseer.nvim.git",
        dependencies = {
            {
                "https://codeberg.org/mfussenegger/nvim-dap.git",
            },
        },
        optional = true,
        opts = {
            dap = false,
        },
    },
    {
        "https://github.com/nvim-neotest/neotest.git",
        dependencies = {
            {
                "https://github.com/stevearc/overseer.nvim.git",
            },
        },
        optional = true,
        opts = function(_, opts)
            opts.consumers = opts.consumers or {}
            opts.consumers.overseer = require("neotest.consumers.overseer")
        end,
    },
    {
        "https://github.com/stevearc/resession.nvim.git",
        optional = true,
        dependencies = {
            "https://codeberg.org/mfussenegger/nvim-dap.git",
        },
        opts = {
            extensions = {
                dap = {},
            },
        },
    },
    {
        "https://github.com/stevearc/resession.nvim.git",
        optional = true,
        dependencies = {
            "https://github.com/stevearc/overseer.nvim.git",
        },
        opts = {
            extensions = {
                overseer = {},
            },
        },
    },
}
