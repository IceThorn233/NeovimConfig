local API = {
    Private = {
        ---@type IceThorn.Library.Layout.Options
        GlobalOptions = {},
        DefaultOptions = {
            Event = { "WinEnter", "BufWinEnter", "FileType" },
        },
        IsInitialized = false,
    },
}

local vapi = vim.api
---@class IceThorn.Library.Layout.Options
---@field Event? vim.api.keyset.events | vim.api.keyset.events[]

---@param Options? IceThorn.Library.Layout.Options
function API.Private.Setup(Options)
    if API.Private.IsInitialized then
        return
    end
    -- API.Private.IsInitialized = true
    -- vapi.nvim_create_namespace("IceThorn.LuaLibrary.Layout")
    -- local emptyBuffer = vapi.nvim_create_buf(false, false)
    -- local leftWin = vapi.nvim_open_win(emptyBuffer, false, {
    --     split = "left",
    --     style = "minimal",
    -- })
    -- vapi.nvim_create_autocmd(API.Private.DefaultOptions.Event, {
    --     callback = function(...)
    --         -- require("LuaLibrary.none").PrintObject(...)
    --     end,
    -- })
end

API.setup = API.Private.Setup
API.Setup = API.Private.Setup

return API
