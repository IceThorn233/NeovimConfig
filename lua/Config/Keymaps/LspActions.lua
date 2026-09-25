local API = {}

if pcall(require, "telescope") then
    API.LspReferences = require("telescope.builtin").lsp_references
elseif pcall(require, "fzf-lua") then
    local FzfLua = require("fzf-lua")
    API.LspReferences = FzfLua.lsp_references
else
    API.LspReferences = vim.lsp.buf.references
end

if pcall(require, "telescope") then
    API.LspDefinitions = require("telescope.builtin").lsp_definitions
elseif pcall(require, "fzf-lua") then
    local FzfLua = require("fzf-lua")
    API.LspDefinitions = FzfLua.lsp_definitions
else
    API.LspDefinitions = vim.lsp.buf.definition
end

if pcall(require, "inc_rename") then
    API.LspRename = function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end
else
    API.LspRename = vim.lsp.buf.rename
end

return API
