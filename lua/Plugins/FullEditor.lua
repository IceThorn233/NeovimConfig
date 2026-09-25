vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Telescope: build extensions and /setup it up in order",
    callback = function(EventArguments)
        ---@type vim.event.packchanged.data
        local Data = EventArguments.data
        local Source = Data.spec.src
        local Name = Data.spec.name
        local Kind = Data.kind
        if
            (
                Name == "telescope-fzf-native.nvim"
                or Source == "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git"
            ) and (Kind == "install" or Kind == "update")
        then
            vim.system({
                "cmake",
                "-S",
                ".",
                "-B",
                "build",
                "-DCMAKE_BUILD_TYPE=Release",
            }, { cwd = Data.path }):wait()
            vim.system({
                "cmake",
                "--build",
                "build",
                "--config",
                "Release",
                "--target",
                "install",
            }, { cwd = Data.path }):wait()
        end
    end,
})

local M = {}
---@type fun(PluginOptions:IceThorn.PluginList):IceThorn.VimPack.Specs
---@param globalPluginOptions IceThorn.PluginList
---@return IceThorn.VimPack.Specs
M.Load = function(globalPluginOptions)
    local PluginOptions = globalPluginOptions.FullEditor or {}
    ---@type IceThorn.VimPack.Specs
    return {
        {
            Source = {
                Url = "https://github.com/nvim-neo-tree/neo-tree.nvim.git",
                Version = vim.version.range("3.*"),
            },
            Condition = PluginOptions.EnableNeoTree,
            Configura = {
                Initialization = function()
                    require("neo-tree").setup({
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
                    })
                end,
            },
        },
        {
            Source = {
                Url = "https://github.com/akinsho/bufferline.nvim.git",
            },
            Condition = PluginOptions.EnableBufferLine and not PluginOptions.EnableCokeLine,
            Configura = {
                Initialization = function()
                    require("bufferline").setup({
                        highlights = require("catppuccin.special.bufferline").get_theme(),
                        options = {
                            right_mouse_command = nil,
                            middle_mouse_command = "Bdelete! %d",
                            close_command = "Bdelete! %d",
                            separator_style = "slant",
                            tab_size = 14,
                            max_name_length = 40,
                            indicator = {
                                style = "underline",
                            },
                            custom_filter = function(bufferName, _)
                                for _, excludeFiletype in ipairs(globalPluginOptions.ExcouldFiletypes or {}) do
                                    if vim.bo[bufferName].filetype == excludeFiletype then
                                        return false
                                    end
                                end
                                return true
                            end,
                            offsets = {},
                            numbers = function(opts)
                                return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
                            end,
                            diagnostics = "nvim_lsp",
                            diagnostics_indicator = function(count, level)
                                return " " .. (level:match("error") and " " or " ") .. count
                            end,
                            pick = {
                                alphabet = "asdfghjkl",
                            },
                            hover = {
                                enabled = true,
                                delay = 200,
                                reveal = { "close" },
                            },
                        },
                    })
                end,
            },
        },
        {
            Source = "https://github.com/willothy/nvim-cokeline.git",
            Condition = PluginOptions.EnableCokeLine, -- and not PluginOptions.EnableBufferLine,
            Configura = function()
                local forceFg = "text"
                local noFg = "overlay0"
                local forceBg = "base"
                local noBg = "mantle"
                require("cokeline").setup({
                    show_if_buffers_are_at_least = 1,

                    buffers = {
                        ---@type false | fun(buf: Buffer):boolean
                        filter_valid = function(buffer)
                            for _, filetype in ipairs(globalPluginOptions.ExcouldFiletypes or {}) do
                                if buffer.filetype == filetype then
                                    return false
                                end
                            end
                            return true
                        end,
                        ---@type false | fun(buf: Buffer):boolean
                        filter_visible = function(buffer)
                            for _, filetype in ipairs(globalPluginOptions.ExcouldFiletypes or {}) do
                                if buffer.filetype == filetype then
                                    return false
                                end
                            end
                            return true
                        end,
                        focus_on_delete = "next",
                        ---@type 'last' | 'next' | 'directory' | 'number' | fun(a: Buffer, b: Buffer):boolean
                        new_buffers_position = "last",
                        delete_on_right_click = false,
                    },
                    mappings = {
                        -- default: `true`.
                        ---@type boolean
                        cycle_prev_next = true,
                        ---@type boolean
                        disable_mouse = false,
                    },
                    pick = {
                        ---@type boolean
                        use_filename = true,
                        -- default: `'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP'`
                        ---@type string
                        letters = "asdfjkl",
                    },
                    default_hl = {
                        ---@type nil | string | fun(buffer: Buffer): string
                        fg = function(buffer)
                            local catppuccin = require("catppuccin.palettes").get_palette()
                            return buffer.is_focused and catppuccin[forceFg] or catppuccin[noFg]
                        end,

                        ---@type nil | string | function(buffer: Buffer): string,
                        bg = function(buffer)
                            local catppuccin = require("catppuccin.palettes").get_palette()
                            return buffer.is_focused and catppuccin[forceBg] or catppuccin[noBg]
                        end,
                    },
                    --
                    --     -- The highlight group used to fill the tabline space
                    --     fill_hl = "TabLineFill",
                    --
                    --     -- A list of components to be rendered for each buffer. Check out the section
                    --     -- below explaining what this value can be set to.
                    --     -- default: see `/lua/cokeline/config.lua`
                    ---@type Component[]
                    components = {
                        -- {
                        --     ---@type nil | string | fun(buffer: Buffer): string
                        --     text = function(buffer)
                        --         if buffer.is_focused then
                        --             return ""
                        --         else
                        --             return ""
                        --         end
                        --     end,
                        --     fg = function()
                        --         local catppuccin = require("catppuccin.palettes").get_palette()
                        --         return catppuccin[forceBg]
                        --     end,
                        --     bg = function()
                        --         local catppuccin = require("catppuccin.palettes").get_palette()
                        --         return catppuccin[noBg]
                        --     end,
                        -- },
                        {
                            text = function(buffer)
                                return (
                                    require("cokeline.mappings").is_picking_focus()
                                    or require("cokeline.mappings").is_picking_close()
                                )
                                        and buffer.pick_letter .. " "
                                    or buffer.devicon.icon
                            end,
                            fg = function(buffer)
                                local catppuccin = require("catppuccin.palettes").get_palette()
                                return catppuccin.sky
                            end,
                        },
                        {
                            text = function(buffer)
                                return buffer.is_readonly and "" or ""
                            end,
                            fg = function(buffer)
                                local catppuccin = require("catppuccin.palettes").get_palette()
                                return catppuccin.sky
                            end,
                        },
                        {
                            text = function(buffer)
                                return buffer.unique_prefix
                            end,
                            fg = require("cokeline.hlgroups").get_hl_attr("Comment", "fg"),
                            italic = true,
                        },
                        {
                            text = function(buffer)
                                return buffer.filename .. " "
                            end,
                            underline = function(buffer)
                                return buffer.is_hovered and not buffer.is_focused
                            end,
                        },
                        {
                            text = function(buffer)
                                if buffer.is_modified then
                                    return " "
                                elseif buffer.is_hovered then
                                    return " "
                                else
                                    return " "
                                end
                            end,
                            on_click = function(_, _, _, _, buffer)
                                buffer:delete()
                            end,
                        },
                        -- {
                        --     ---@type nil | string | fun(buffer: Buffer): string
                        --     text = function(buffer)
                        --         if buffer.is_focused then
                        --             return ""
                        --         else
                        --             return ""
                        --         end
                        --     end,
                        --     fg = function()
                        --         local catppuccin = require("catppuccin.palettes").get_palette()
                        --         return catppuccin[forceBg]
                        --     end,
                        --     bg = function()
                        --         local catppuccin = require("catppuccin.palettes").get_palette()
                        --         return catppuccin[noBg]
                        --     end,
                        -- },
                    },
                    --
                    --     -- Custom areas can be displayed on the right hand side of the bufferline.
                    --     -- They act identically to buffer components, except their methods don't take a Buffer object.
                    --     -- If you want a rhs component to be stateful, you can wrap it in a closure containing state.
                    --     ---@type Component[] | false
                    --     rhs = {},
                    --
                    --     -- Tabpages can be displayed on either the left or right of the bufferline.
                    --     -- They act the same as other components, except they are passed TabPage objects instead of
                    --     -- buffer objects.
                    --     ---@type table | false
                    --     tabs = {
                    --         placement = "left" ,
                    --         ---@type Component[]
                    --         components = {},
                    --     },
                    --
                    --     -- Left sidebar to integrate nicely with file explorer plugins.
                    --     -- This is a table containing a `filetype` key and a list of `components` to
                    --     -- be rendered in the sidebar.
                    --     -- The last component will be automatically space padded if necessary
                    --     -- to ensure the sidebar and the window below it have the same width.
                    --     ---@type table | false
                    sidebar = {
                        ---@type string | string[]
                        filetype = require("LuaLibrary").List.Merge(
                            globalPluginOptions.ExcouldFiletypes or {},
                            { "NvimTree", "neo-tree", "SidebarNvim" }
                        ),
                        components = {
                            {
                                ---@param buf Buffer
                                text = function(buf)
                                    return buf.is_hovered and " " or " "
                                end,
                                on_click = function(...)
                                    require("LuaLibrary").PrintObject({ ... })
                                end,
                            },
                            {
                                text = function(buf)
                                    return buf.filetype
                                end,
                                bold = true,
                            },
                        },
                    },
                })
            end,
        },
        {
            Source = { Url = "https://github.com/nvim-lualine/lualine.nvim.git" },
            Condition = PluginOptions.EnableLualine,
            Configura = {
                Initialization = function()
                    require("lualine").setup({
                        options = {
                            theme = "catppuccin-nvim",
                        },
                    })
                end,
            },
        },
        {
            Source = { Url = "https://github.com/Bekaboo/dropbar.nvim.git" },
            Condition = PluginOptions.EnableDropbar,
            Configura = {
                Initialization = function()
                    require("dropbar").setup()
                end,
            },
        },
        {
            Source = { Url = "https://github.com/MagicDuck/grug-far.nvim.git" },
            Condition = PluginOptions.EnableGrugFar,
            Configura = {
                Initialization = function()
                    require("grug-far").setup({
                        headerMaxWidth = 80,
                    })
                end,
            },
        },
        {
            Source = { Url = "https://github.com/folke/edgy.nvim.git" },
            Condition = PluginOptions.EnableEdgy and not PluginOptions.EnableLayout,
            Configura = {
                Initialization = function()
                    require("edgy").setup({
                        left = {},
                        ---@type (Edgy.View.Opts|string)[]
                        bottom = {
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
                            -- winbar = false,
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
                    })
                end,
            },
        },
        {
            Source = "https://github.com/lucobellic/layout.nvim.git",
            Condition = PluginOptions.EnableLayout and not PluginOptions.EnableEdgy,
            Configura = function()
                require("layout").setup({
                    ---@type Layout.Side.Entry
                    left = {
                        size = 40, -- cells, or a fraction such as 0.25
                        groups = {
                            {
                                name = "Explorer",
                                views = {
                                    {
                                        name = "filesystem",
                                        filter = "neo-tree",
                                        open = "Neotree action=show source=filesystem position=left",
                                    },
                                },
                            },
                            {
                                name = "Replace",
                                views = {
                                    {
                                        name = "filesystem",
                                        filter = "grug-far",
                                        open = "GrugFar",
                                    },
                                },
                            },
                        },
                    },
                    right = { size = 40, groups = {} },
                    bottom = {
                        size = 15,
                        align = "full",
                        groups = {
                            -- {
                            --     name = "Terminal",
                            --     views = {
                            --         {
                            --             name = "filesystem",
                            --             filter = "toggleterm",
                            --             open = "ToggleTerm",
                            --         },
                            --     },
                            -- },
                        },
                    },
                    -- events = { "FileType", "WinEnter", "BufWinEnter" },
                    -- tabpage_scoped_sizes = true, -- remember panel and view sizes independently per tabpage
                    -- live_resize_debounce = 250,
                })
            end,
        },
        {
            Source = { Url = "https://github.com/nvim-telescope/telescope.nvim.git" },
            Condition = PluginOptions.EnableTelescope,
            Configura = function()
                local Telescope = require("telescope")
                Telescope.setup({
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
                })
            end,
        },
        {
            Source = { Url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim.git" },
            Name = "telescope-fzf-native.nvim",
            Condition = PluginOptions.EnableTelescope and PluginOptions.EnableTelescopeFzfNative,
            Configura = {
                Initialization = function()
                    require("telescope").load_extension("fzf")
                end,
            },
        },
        {
            Source = { Url = "https://github.com/akinsho/toggleterm.nvim" },
            Condition = PluginOptions.EnableToggleTerm,
            Configura = {
                Initialization = function()
                    require("toggleterm").setup({
                        open_mapping = "<C-t>",
                        direction = 'tab'
                    })
                end,
            },
        },
    }
end
return M
