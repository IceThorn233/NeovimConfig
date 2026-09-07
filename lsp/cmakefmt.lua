---@type vim.lsp.Config
return {
	cmd = { "cmakefmt","lsp" },
	filetypes = { "cmake" },
	root_markers = { "CMakeLists.txt", "CMakePresets.json", "CMakeUserPresets.json" },
}
