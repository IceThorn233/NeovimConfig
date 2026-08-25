local function CheckIfTheModuleExists(ModuleName)
	return pcall(require, ModuleName)
end

vim.lsp.log.set_level(vim.log.levels.OFF)

vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = true,
	underline = true,
})
vim.lsp.enable({
	"bashls",
	"zls",
	"rust-analyzer",
	"ccls",
	"tablo",
	"lua_ls",
	"jsonls",
	"lemminx",
	"neocmake",
	"yamlls",
})

-- local HasSchemaStore = CheckIfTheModuleExists("schemastore")
local HasOmniSharpExtended = CheckIfTheModuleExists("omnisharp_extended")

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {},
		tsserver = {
		},
	},
})
if HasOmniSharpExtended then
	vim.lsp.enable("omnisharp")
	vim.lsp.config("omnisharp", {
		---@type lspconfig.settings.omnisharp
		settings = {
			razor = {
				enable = true,
				format = {
					enable = true,
				},
				completion = {
					commitElementsWithSpace = true,
				},
			},
			omnisharp = {
				enableMsBuildLoadProjectsOnDemand = true,
				loggingLevel = "information",
			},
			csharp = {
				referencesCodeLens = {},
				format = {
					enable = true,
				},
			},
			dotnet = {
				enableXamlTools = true,
				completion = {
					provideRegexCompletions = true,
				},
				formatting = {},
				codeLens = {
					enableReferencesCodeLens = true,
					enableTestsCodeLens = false,
				},
			},
			RenameOptions = {
				RenameInComments = true,
				RenameOverloads = true,
				RenameInStrings = nil,
			},
		},
		handlers = {
			["textDocument/definition"] = require("omnisharp_extended").definition_handler,
			["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
			["textDocument/references"] = require("omnisharp_extended").references_handler,
			["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
		},
	})
end
vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=never",
		"--completion-parse=auto",
		"--completion-style=bundled",
		"--function-arg-placeholders",
		"--fallback-style=microsoft",
		"--pch-storage=memory",
		"--function-arg-placeholders=false",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
})
vim.lsp.config("ccls", {
	-- single_file_support = true,
	init_options = {
		compilationDatabaseDirectory = "build",
		cache = {
			directory = ".cache/ccls",
		},
		index = {
			threads = 32,
		},
	},
})
vim.lsp.config("lemminx", {
	settings = {
		xml = {
			format = {
				formatComments = false,
				splitAttributes = true,
			},
			completion = {
				autoCloseTags = true,
			},
			validation = {
				enable = false,
			},
			catalogs = {
				vim.fn.stdpath("config") .. "/Schema/XML/StandardCatalog.xml",
			},
			fileAssociations = {
				{
					pattern = "**/*.{props,targets,csproj,esproj,proj}",
					systemId = "https://fastly.jsdelivr.net/gh/dotnet/msbuild@main/src/MSBuild/Microsoft.Build.xsd",
				},
				{
					pattern = "**/*.slnx",
					systemId = "https://fastly.jsdelivr.net/gh/microsoft/vs-solutionpersistence@main/src/Microsoft.VisualStudio.SolutionPersistence/Serializer/Xml/Slnx.xsd",
				},
			},
		},
	},
})
vim.lsp.config("rust_analyzer", {
	["rust-analyzer"] = {
		lens = {
			debug = {
				enable = true,
			},
			enable = true,
			implementations = {
				enable = true,
			},
			references = {
				adt = {
					enable = true,
				},
				enumVariant = {
					enable = true,
				},
				method = {
					enable = true,
				},
				trait = {
					enable = true,
				},
			},
			run = {
				enable = true,
			},
			updateTest = {
				enable = true,
			},
		},
	},
})
vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemas = {
				["https://www.schemastore.org/clang-format-21.x.json"] = ".clang-format",
				["https://www.schemastore.org/clang-tidy.json"] = ".clang-tidy",
			},
		},
	},
})
vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = {
				{
					fileMatch = {
						"tasks.json",
					},
					url = vim.fn.stdpath("config") .. "/Schema/JSON/VisualStudioCode.Tasks.Schema.json",
				},
				{
					fileMatch = {
						"launch.json",
					},
					url = "https://codeberg.org/mfussenegger/dapconfig-schema/raw/branch/master/dapconfig-schema.json",
				},
				{
					fileMatch = {
						"CMakePresets.json",
						"CMakeUserPresets.json",
					},
					url = "https://fastly.jsdelivr.net/gh/Kitware/CMake@master/Help/manual/presets/schema.json",
				},
				{
					fileMatch = {
						"vcpkg-tools.json",
					},
					url = "https://fastly.jsdelivr.net/gh/microsoft/vcpkg-tool@main/docs/vcpkg-tools.schema.json",
				},
				{
					fileMatch = {
						"vcpkg-configuration.json",
					},
					url = "https://fastly.jsdelivr.net/gh/microsoft/vcpkg-tool@main/docs/vcpkg-configuration.schema.json",
				},
				{
					fileMatch = {
						"vcpkg.json",
					},
					url = "https://fastly.jsdelivr.net/gh/microsoft/vcpkg-tool@main/docs/vcpkg.schema.json",
				},
				{
					fileMatch = {
						"package.json",
					},
					url = "https://fastly.jsdelivr.net/gh/SchemaStore/schemastore@master/src/schemas/json/package.json",
				},
			},
		},
	},
})
