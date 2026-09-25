local M = {}
---@return IceThorn.VimPack.Specs
M.Load = function(_)
    ---@type IceThorn.VimPack.Specs
    return {
        "https://github.com/nvim-tree/nvim-web-devicons.git",
        "https://github.com/nvim-lua/plenary.nvim.git",
        "https://github.com/MunifTanjim/nui.nvim.git",
    }
end
return M
