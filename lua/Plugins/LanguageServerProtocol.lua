local M = {}
---@param GlobalPluginOptions IceThorn.PluginList
---@return IceThorn.VimPack.Specs
function M.Load(GlobalPluginOptions)
    local PluginOptions = GlobalPluginOptions.LanguageServerProtocol or {}
    ---@type IceThorn.VimPack.Specs
    return {
        "https://github.com/neovim/nvim-lspconfig.git",
        {
            Source = "https://github.com/bydlw98/blink-cmp-env.git",
            Condition = PluginOptions.EnableBlinkCmp and not PluginOptions.EnableNVimCmp,
        },
        {
            Source = "https://github.com/onsails/lspkind.nvim.git",
            Condition = PluginOptions.EnableBlinkCmp or PluginOptions.EnableNVimCmp,
        },
        {
            Source = {
                Url = "https://github.com/L3MON4D3/LuaSnip.git",
            },
            Condition = PluginOptions.EnableLuaSnip,
            Configura = {
                Initialization = function()
                    require("luasnip").filetype_extend("c", { "cdoc" })
                    require("luasnip").filetype_extend("cpp", { "cppdoc" })
                    require("luasnip").filetype_extend("cs", { "csharp", "csharpdoc" })
                    require("luasnip").filetype_extend("csharp", { "csharp", "csharpdoc" })
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_snipmate").lazy_load()
                    require("luasnip.loaders.from_lua").lazy_load()
                    vim.api.nvim_create_user_command("LuaSnipReload", function()
                        require("luasnip.loaders.from_vscode").load()
                        require("luasnip.loaders.from_snipmate").load()
                        require("luasnip.loaders.from_lua").load()
                    end, { desc = "Reload vscode style snippets." })
                    vim.api.nvim_create_user_command("LuaSnipEditSnippets", function()
                        require("luasnip.loaders").edit_snippet_files()
                    end, {})
                end,
            },
        },
        {
            Source = {
                Url = "https://github.com/saghen/blink.cmp.git",
                Version = vim.version.range("1.*"),
            },
            Condition = PluginOptions.EnableBlinkCmp
                and PluginOptions.EnableLuaSnip
                and not PluginOptions.EnableNVimCmp,
            Configura = function()
                local BlinkCmpOptions = {
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
                }
                require("blink.cmp").setup(BlinkCmpOptions)
            end,
        },
        {
            Source = "https://github.com/saadparwaiz1/cmp_luasnip.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
        },
        {
            Source = "https://github.com/L3MON4D3/cmp-luasnip-choice.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
            Configura = function()
                require("cmp_luasnip_choice").setup({
                    auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
                })
            end,
        },
        {
            Source = "https://github.com/hrsh7th/cmp-nvim-lsp.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
        },
        {
            Source = "https://github.com/hrsh7th/cmp-buffer.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
        },
        {
            Source = "https://github.com/bydlw98/cmp-env.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
        },
        {
            Source = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
        },
        {
            Source = "https://github.com/hrsh7th/nvim-cmp.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
            Configura = function()
                local KeymappingFallback = function(Fallback)
                    Fallback()
                end
                -- local PresetKeymapping = require("cmp").mapping.preset.insert({
                --     ["<A-p>"] = require("cmp").mapping.scroll_docs(-4),
                --     ["<A-n>"] = require("cmp").mapping.scroll_docs(4),
                --     ["<DOWN>"] = require("cmp").mapping.select_next_item({
                --         behavior = require("cmp").SelectBehavior.Insert,
                --     }),
                --     ["<UP>"] = require("cmp").mapping.select_prev_item({
                --         behavior = require("cmp").SelectBehavior.Insert,
                --     }),
                --     ["<A-j>"] = require("cmp").mapping.select_next_item({
                --         behavior = require("cmp").SelectBehavior.Insert,
                --     }),
                --     ["<A-k>"] = require("cmp").mapping.select_prev_item({
                --         behavior = require("cmp").SelectBehavior.Insert,
                --     }),
                --     ["<A-SPACE>"] = require("cmp").mapping.complete(),
                --     ["<C-SPACE>"] = require("cmp").mapping.close(),
                --     ["<TAB>"] = require("cmp").mapping(function(Fallback)
                --         local Cmp = require("cmp")
                --         local Luasnip = require("luasnip")
                --         if Cmp.visible() then
                --             Cmp.confirm({
                --                 select = true,
                --             })
                --         elseif Luasnip.locally_jumpable(1) then
                --             Luasnip.jump(1)
                --         else
                --             Fallback()
                --         end
                --     end),
                --     ["<S-TAB>"] = require("cmp").mapping(function()
                --         require("luasnip").jump(1)
                --     end),
                --     ["<C-n>"] = KeymappingFallback,
                --     ["<C-p>"] = KeymappingFallback,
                --     ["<C-e>"] = KeymappingFallback,
                --     ["<C-y>"] = KeymappingFallback,
                -- })

                require("cmp").setup({
                    snippet = {
                        expand = function(args)
                            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                        end,
                    },
                    window = {
                        -- completion = {
                        --     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        --     col_offset = -3,
                        --     side_padding = 0,
                        -- },
                        -- documentation = require("cmp").config.window.bordered(),
                    },
                    mapping = {
                        ["<A-p>"] = require("cmp").mapping.scroll_docs(-4),
                        ["<A-n>"] = require("cmp").mapping.scroll_docs(4),
                        ["<DOWN>"] = require("cmp").mapping.select_next_item({
                            behavior = require("cmp").SelectBehavior.Insert,
                        }),
                        ["<UP>"] = require("cmp").mapping.select_prev_item({
                            behavior = require("cmp").SelectBehavior.Insert,
                        }),
                        ["<A-j>"] = require("cmp").mapping.select_next_item({
                            behavior = require("cmp").SelectBehavior.Insert,
                        }),
                        ["<A-k>"] = require("cmp").mapping.select_prev_item({
                            behavior = require("cmp").SelectBehavior.Insert,
                        }),
                        ["<A-SPACE>"] = require("cmp").mapping.complete(),
                        ["<C-SPACE>"] = require("cmp").mapping.close(),
                        ["<TAB>"] = require("cmp").mapping(function(Fallback)
                            local Cmp = require("cmp")
                            local Luasnip = require("luasnip")
                            if Cmp.visible() then
                                Cmp.confirm({
                                    select = true,
                                })
                            elseif Luasnip.locally_jumpable(1) then
                                Luasnip.jump(1)
                            else
                                Fallback()
                            end
                        end),
                        ["<S-TAB>"] = require("cmp").mapping(function()
                            require("luasnip").jump(1)
                        end),
                        ["<C-n>"] = KeymappingFallback,
                        ["<C-p>"] = KeymappingFallback,
                        ["<C-y>"] = KeymappingFallback,
                        ["<C-e>"] = KeymappingFallback,
                    },
                    sources = require("cmp").config.sources({
                        { name = "nvim_lsp" },
                        { name = "nvim_lsp_signature_help" },
                        { name = "luasnip" },
                        { name = "luasnip_choice" },
                        { name = "path" },
                        { name = "env" },
                    }, { name = "buffer" }),
                    formatting = {
                        fields = { "abbr", "icon", "kind", "menu" },
                        format = function(Entry, VimItem)
                            local LspKind = require("lspkind")
                            local Kind = LspKind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(Entry, VimItem)
                            Kind.icon = " " .. (Kind.icon or "") .. "  "
                            Kind.kind = "   (" .. (Kind.kind or "") .. ")"
                            return Kind
                        end,
                    },
                })
                vim.lsp.config("*", {
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                })
            end,
        },
        {
            Source = "https://github.com/hrsh7th/cmp-path.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
        },
        {
            Source = "https://github.com/hrsh7th/cmp-cmdline.git",
            Condition = PluginOptions.EnableNVimCmp and not PluginOptions.EnableBlinkCmp,
            Configura = function()
                local KeymappingFallback = function(Fallback)
                    Fallback()
                end
                local CommandLineKeymapping = require("cmp").mapping({
                    ["<A-p>"] = require("cmp").mapping.scroll_docs(-4),
                    ["<A-n>"] = require("cmp").mapping.scroll_docs(4),
                    ["<DOWN>"] = require("cmp").mapping.select_next_item({
                        behavior = require("cmp").SelectBehavior.Insert,
                    }),
                    ["<UP>"] = require("cmp").mapping.select_prev_item({
                        behavior = require("cmp").SelectBehavior.Insert,
                    }),
                    ["<A-j>"] = require("cmp").mapping.select_next_item({
                        behavior = require("cmp").SelectBehavior.Insert,
                    }),
                    ["<A-k>"] = require("cmp").mapping.select_prev_item({
                        behavior = require("cmp").SelectBehavior.Insert,
                    }),
                    ["<A-SPACE>"] = require("cmp").mapping.complete(),
                    ["<C-SPACE>"] = require("cmp").mapping.close(),
                    ["<TAB>"] = require("cmp").mapping.confirm({ select = true }),
                })
                -- require("cmp").setup.cmdline({ "/", "?" }, {
                --     mapping = CommandLineKeymapping,
                --     sources = {
                --         { name = "buffer" },
                --     },
                -- })
                require("cmp").setup.cmdline(":", {
                    completion = { autocomplete = false },
                    mapping = require("cmp").mapping.preset.cmdline(),
                    sources = require("cmp").config.sources({
                        { name = "path" },
                        { name = "cmdline" },
                    }, {}),
                })
            end,
        },
        {
            Source = "https://github.com/j-hui/fidget.nvim.git",
            Condition = PluginOptions.EnableFridget,
            Configura = function()
                require("fidget").setup({})
            end,
        },
        {
            Source = "https://github.com/folke/trouble.nvim.git",
            Condition = PluginOptions.EnableTrouble,
            Configura = function()
                require("trouble").setup({})
            end,
        },
        {
            Source = "https://codeberg.org/mfussenegger/nvim-lint.git",
            Condition = PluginOptions.EnableNVimLint,
            Configura = function(Overwrite)
                require("lint").linters_by_ft = require("LuaLibrary").Table.TableDeepExtend("Keep", Overwrite, {})
                vim.api.nvim_create_autocmd("BufWritePost", {
                    callback = function()
                        require("lint").try_lint()
                    end,
                })
            end,
        },
    }
end
return M
