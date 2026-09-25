local API = {}
API.ConstantVariables = {
    Namespace = "IceThorn.VimPackManager",
    NamespaceId = nil,
    BuferNr = nil,
    FileType = "VimPackManager",
}

API.Setup = function()
    API.ConstantVariables.NamespaceId = vim.api.nvim_create_namespace(API.ConstantVariables.Namespace)
    vim.diagnostic.config({
        virtual_text = {
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR,
            },
        },
    }, API.ConstantVariables.NamespaceId)
    API.ConstantVariables.BuferNr = vim.api.nvim_create_buf(true, true)
end
API.OpenVimPackManager = function() end

return API
