local Dap = require("dap")

Dap.set_log_level("TRACE")
---@type dap.Adapter|dap.AdapterFactory
local CodeLldb = {
    type = "executable",
    command = "codelldb",
}
-- ---@type dap.Adapter|dap.AdapterFactory
-- local LldbDap = {
--     type = "executable",
--     command = "lldb-dap",
--     name = "lldb",
-- }
---@type dap.ExecutableAdapter
local LldbDap = {
    type = "executable",
    command = "/bin/lldb-dap",
    args = { "--client", "vscode", "-g" },
    name = "lldb",
    options = {},
}
---@type dap.Adapter|dap.AdapterFactory
local Gdb = {
    id = "gdb",
    type = "executable",
    command = "gdb",
    args = { "--quiet", "--interpreter=dap" },
}
---@type dap.Adapter|dap.AdapterFactory
local NetcoreDbg = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
}
Dap.adapters.coreclr = NetcoreDbg
Dap.adapters.lldb = LldbDap
Dap.adapters.codelldb = CodeLldb
Dap.adapters["lldb-dap"] = LldbDap
Dap.adapters.gdb = Gdb
return {
    ["CodeLldb"] = CodeLldb,
    ["LldbDap"] = LldbDap,
    ["Gdb"] = Gdb,
    ["NetcoreDbg"] = NetcoreDbg,
}
