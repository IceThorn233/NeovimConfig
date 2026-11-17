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
        -- {
        --     Source = "https://github.com/saghen/blink.lib",
        -- },
        -- {
        --     Source = {
        --         Url = "https://github.com/saghen/blink.cmp.git",
        --         Version = "in-process-lsp",
        --     },
        --     Condition = PluginOptions.EnableBlinkCmp
        --         and PluginOptions.EnableLuaSnip
        --         and not PluginOptions.EnableNVimCmp,
        --     Configura = function()
        --         require('blink.cmp').build({ dev = true })
        --         require("blink.cmp").setup({
        --             keymap = {
        --                 preset = "super-tab",
        --                 ["<C-g>"] = { "accept", "fallback" },
        --                 ["<C-d>"] = { "select_next", "fallback" },
        --                 ["<C-c>"] = { "select_prev", "fallback" },
        --             },
        --             appearance = { nerd_font_variant = "normal" },
        --             signature = { enabled = true },
        --             cmdline = { enabled = false },
        --         })
        --     end,
        -- },
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
                require("lint").linters["clangtidy"].args = {
                    "--quiet",
                    "-p",
                    "build",
                }
                vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
                    callback = function()
                        require("lint").try_lint()
                    end,
                })
            end,
        },
    }
end
return M
