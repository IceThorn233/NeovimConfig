return {
    "https://github.com/catppuccin/nvim.git",
    name = "catppuccin",
    ---@type CatppuccinOptions
    opts = {
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
            colorful_winsep = {
                enabled = true,
            },
            blink_indent = true,
            diffview = true,
            dropbar = {
                enabled = true,
                color_mode = true,
            },
            fzf = true,
            gitsigns = true,
            grug_far = true,
            neotree = true,
            leap = true,
            neotest = true,
            neogit = true,
            dap = true,
            telescope = {
                enabled = true,
            },
            lsp_trouble = true,
            which_key = true,
            illuminate = true,
        },
    },
}
