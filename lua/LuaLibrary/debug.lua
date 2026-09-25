local API = {
    Private = {},
}

local range = require("LuaLibrary.list").Range
function API.Private.Setup()
    vim.api.nvim_create_user_command("IceThornDebugPrintLayout", function(_)
        require("LuaLibrary.none").PrintObject(vim.fn.winlayout())
    end, {})
    vim.api.nvim_create_user_command("IceThornDebugListWindow", function(_)
        local none = require("LuaLibrary.none")
        none.PrintObject(range
            .New(vim.api.nvim_list_wins())
            :Transform(function(item)
                return {
                    Width = vim.api.nvim_win_get_width(item),
                    Hight = vim.api.nvim_win_get_height(item),
                    Buffer = vim.api.nvim_win_get_buf(item),
                    Number = vim.api.nvim_win_get_number(item),
                    Cursor = vim.api.nvim_win_get_cursor(item),
                }
            end)
            :Unpack())
    end, {})
end

API.Setup = API.Private.Setup
API.setup = API.Private.Setup
return API
