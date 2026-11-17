return {
    {
        "https://github.com/saghen/blink.cmp.git",
        dependencies = {
            "https://github.com/onsails/lspkind.nvim.git",
            "https://github.com/L3MON4D3/LuaSnip.git",
            "https://github.com/bydlw98/blink-cmp-env.git",
        },
        version = "1.*",
        opts = {
            snippets = {
                preset = "luasnip",
            },
            keymap = {
                preset = "none",
                ["<A-k>"] = { "select_prev", "fallback" },
                ["<A-j>"] = { "select_next", "fallback" },
                ["<UP>"] = { "select_prev", "fallback" },
                ["<DOWN>"] = { "select_next", "fallback" },
                ["<TAB>"] = { "accept", "snippet_forward", "fallback" },
                ["<S-TAB>"] = { "snippet_backward", "fallback" },
                ["<ESC>"] = { "fallback" },
                ["<A-n>"] = { "scroll_documentation_down", "fallback" },
                ["<A-p>"] = { "scroll_documentation_up", "fallback" },
                ["<A-SPACE>"] = { "show" },
                ["<C-SPACE>"] = { "hide" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            cmdline = {
                enabled = true,
                keymap = {
                    preset = "inherit",
                },
                completion = {
                    ghost_text = {
                        enabled = true,
                    },
                    menu = {
                        auto_show = true,
                    },
                },
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 1,
                    treesitter_highlighting = true,
                    window = {
                        min_width = 60,
                        max_width = 75,
                        max_height = 40,
                        border = "rounded",
                    },
                },
                trigger = {
                    show_on_keyword = true,
                },
                ghost_text = {
                    enabled = true,
                    show_with_menu = true,
                },
                menu = {
                    enabled = true,
                    border = "rounded",
                    scrollbar = true,
                    max_height = 30,
                    min_width = 30,
                    scrolloff = 4,
                    draw = {
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    return string.format(
                                        "%s [%s]",
                                        require("lspkind").symbol_map[ctx.kind] or " ",
                                        ctx.source_name
                                    )
                                end,
                            },
                        },
                    },
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                },
            },
            sources = {
                per_filetype = {},
                default = {
                    "lsp",
                    "path",
                    "env",
                    "snippets",
                    "buffer",
                },
                providers = {
                    env = {
                        name = "Env",
                        module = "blink-cmp-env",
                        ---@type blink-cmp-env.Options
                        opts = {},
                    },
                    snippets = {},
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
    },
}
