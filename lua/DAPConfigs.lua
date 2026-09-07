local Dap = require("dap")

local CodeLldb = {
	type = "server",
	port = "${port}",
	command = "codelldb",
	args = {
		"--port",
		"${port}",
	},
}
local LldbDap = {
	type = "executable",
	command = "lldb-dap",
}
local Gdb = {
	id = "gdb",
	type = "executable",
	command = "gdb",
	args = { "--quiet", "--interpreter=dap" },
}
local NetcoreDbg = {
	type = "executable",
	command = "netcoredbg",
	args = { "--interpreter=vscode" },
}
Dap.adapters.coreclr = NetcoreDbg
Dap.adapters.lldb = CodeLldb
Dap.adapters.codelldb = CodeLldb
Dap.adapters["lldb-dap"] = LldbDap
Dap.adapters.gdb = Gdb
