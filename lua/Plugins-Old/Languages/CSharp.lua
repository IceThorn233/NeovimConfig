---@type LazySpec
return {
    {
        "mason-org/mason-lspconfig.nvim",
        optional = true,
        opts = function(_, Options)
            Options.ensure_installed = Options.ensure_installed or {}
            table.insert(Options.ensure_installed, "omnisharp")
        end,
    },
    {
        "romus204/tree-sitter-manager.nvim",
        optional = true,
        opts = function(_, Options)
            Options.ensure_installed = Options.ensure_installed or {}
            table.insert(Options.ensure_installed, "c_sharp")
            table.insert(Options.ensure_installed, "fsharp")
        end,
    },
    {
        "Hoffs/omnisharp-extended-lsp.nvim",
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "Issafalcon/neotest-dotnet",
        },
        optional = true,
        ---@type neotest.Config | fun(_,neotest.Config)
        ---@param NeotestOption neotest.Config
        opts = function(_, NeotestOption)
            NeotestOption = NeotestOption or {}
            NeotestOption.adapters = NeotestOption.adapters or {}
            table.insert(
                NeotestOption.adapters,
                require("neotest-dotnet")({
                    dap = {
                        adapter_name = "netcoredbg",
                    },
                })
            )
        end,
    },
}
