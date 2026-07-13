return {
    {
        "b0o/SchemaStore.nvim",
        config = function (_,_)
            require("schemastore").yaml.schemas({})
        end
    },
	{
		"mason-org/mason-lspconfig.nvim",
		optional = true,
		opts = function(_, Options)
			Options.ensure_installed = Options.ensure_installed or {}
			table.insert(Options.ensure_installed, "jsonls")
		end,
	},
}
