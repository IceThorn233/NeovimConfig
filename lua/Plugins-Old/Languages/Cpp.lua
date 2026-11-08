---@type LazySpec
return {
    {
        "mfussenegger/nvim-lint",
        optional = true,
        opts = function(_, _)
            require("lint").linters_by_ft.cmake = { "cmakelint" }
        end,
    },
    {
        "danymat/neogen",
        opts = {
            snippet_engine = "luasnip",
        },
        config = function(_, Options)
            require("neogen").setup(Options)
        end,
    },
    -- {
    -- 	"mason-org/mason.nvim",
    -- 	optional = true,
    -- 	opts = function(_, Options)
    -- 		Options.ensure_installed = Options.ensure_installed or {}
    -- 		table.insert(Options.ensure_installed, "")
    -- 	end,
    -- },
    {
        "jay-babu/mason-nvim-dap.nvim",
        optional = true,
        opts = function(_, Options)
            Options.ensure_installed = Options.ensure_installed or {}
            table.insert(Options.ensure_installed, "codelldb")
        end,
    },
    -- {
    -- 	"mason-org/mason-lspconfig.nvim",
    -- 	optional = true,
    -- 	opts = function(_, Options)
    -- 		Options.ensure_installed = Options.ensure_installed or {}
    -- 		table.insert(Options.ensure_installed, "ccls")
    -- 	end,
    -- },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "orjangj/neotest-ctest",
        },
        optional = true,
        ---@type neotest.Config | fun(_,neotest.Config)
        ---@param NeotestOption neotest.Config
        opts = function(_, NeotestOption)
            NeotestOption = NeotestOption or {}
            NeotestOption.adapters = NeotestOption.adapters or {}
            table.insert(
                NeotestOption.adapters,
                require("neotest-ctest").setup({
                    root = function(RootDirectory)
                        return require("neotest.lib").files.match_root_pattern(
                            "CMakePresets.json",
                            "CMakeUserPresets.json",
                            "CMakeLists.txt",
                            ".cache",
                            ".clangd",
                            ".ccls",
                            ".vscode",
                            ".zed",
                            "build",
                            "out",
                            ".git"
                        )(RootDirectory)
                    end,
                })
            )
        end,
    },
    {
        "Blackcyan30/nvim-doccomment-tags",
        opts = ,
        config = function(_, Options)
            require("nvim-doccomment-tags.doccomment-tags").setup(Options)
        end,
    },
}
