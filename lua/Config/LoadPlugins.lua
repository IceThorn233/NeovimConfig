---@alias IceThorn.PluginList.Preset string | "None" | "Default" | "LuaOnly" | "VsCode"
---@class IceThorn.PluginList
---@field ExcouldFiletypes?       string[]
---@field Preset?                 IceThorn.PluginList.Preset
---@field Editor?                 IceThorn.PluginList.Editor
---@field FullEditor?             IceThorn.PluginList.FullEditor
---@field LanguageServerProtocol? IceThorn.PluginList.LanguageServerProtocol
---@field Formatter?              IceThorn.PluginList.Formatter
---@field Treesitter?             IceThorn.PluginList.Treesitter
---@field PackageManager?         IceThorn.PluginList.PackageManager
---@field Themes?                 IceThorn.PluginList.Themes
---@field Extras?                 IceThorn.PluginList.Extras

---@class IceThorn.PluginList.Editor
---@field EnableNVimHighlightColors? boolean
---@field EnableWhichKey?            boolean
---@field EnableMiniSurround?        boolean
---@field EnableImage?               boolean
---@field EnableAutoPair?            boolean
---@field EnableTodoComment?         boolean
---@field EnableScrollView?          boolean
---@field EnableIlluminate?          boolean
---@field EnableIndentBlankline?     boolean
---@field EnableLeap?                boolean
---@field IndentBlacklinePreset?     "IndentBlackline" | "BlinkIndent" | "Hlchunk"

---@class IceThorn.PluginList.FullEditor
---@field EnableNeoTree?            boolean
---@field EnableBufferLine?         boolean
---@field EnableCokeLine?           boolean
---@field EnableLualine?            boolean
---@field EnableDropbar?            boolean
---@field EnableGrugFar?            boolean
---@field EnableEdgy?               boolean
---@field EnableLayout?             boolean
---@field EnableTelescope?          boolean
---@field EnableTelescopeFzfNative? boolean
---@field EnableToggleTerm?         boolean

---@class IceThorn.PluginList.LanguageServerProtocol
---@field EnableBlinkCmp?         boolean
---@field EnableNVimCmp?          boolean
---@field EnableLuaSnip?          boolean
---@field EnableFirendlySnippets? boolean
---@field EnableFridget?          boolean
---@field EnableTrouble?          boolean
---@field EnableNVimLint?         boolean

---@class IceThorn.PluginList.Formatter
---@field EnableConform?     boolean

---@class IceThorn.PluginList.PackageManager
---@field EnableMeson? boolean
---@field FormaterToInstall? string[]
---@field LanguageServerProtocolToInstall? string[]
---@field DebugAdapterProtocolToInstall? string[]

---@class IceThorn.PluginList.Treesitter
---@field EnableNVimTreesitter?           boolean
---@field EnableNVimTsCommentstring?      true
---@field EnableNVimTreesitterTextobject? boolean
---@field NVimTsCommentStringPreset?      "NvimTsContextCommentstring" | "TsComment"

---@class IceThorn.PluginList.Themes
---@field EnableCatppuccin? boolean
---@field EnableDashboard?  boolean
---@field EnableLiteUi?     boolean
---@field EnableVimQuickUi? boolean
---@field EnableMenu?       boolean
---@field EnableDressing?   boolean
---@field DashboardPlugin?  "AlphaNVim" | "ProfileNVim" | "NVimDashboard"

---@class IceThorn.PluginList.Extras
---@field EnableCAndCpp? boolean
local M = {
    UserOptions = {},
    PrivateFunction = require("LuaLibrary"),
    Presets = {
        ---@type IceThorn.PluginList
        Default = {},
        ---@type IceThorn.PluginList
        LuaOnly = {},
        ---@type IceThorn.PluginList
        VsCode = {},
        ---@type IceThorn.PluginList
        None = {},
    },
}
---@type IceThorn.PluginList
local PresetDefault = {
    Preset = "Default",
    ExcouldFiletypes = {
        "aplha",
        "trouble",
        "toggleterm",
        "grug-far",
        "neo-tree",
        "checkhealth",
        "man",
        "better_term",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
        "dap-repl",
        "dap-view",
        "grug-far",
        "toggleterm",
        "OverseerList",
        "OverseerOutput",
        "VimPackManager",
    },
    Editor = {
        EnableNVimHighlightColors = true,
        EnableWhichKey = true,
        EnableMiniSurround = true,
        EnableImage = true,
        EnableAutoPair = true,
        EnableTodoComment = true,
        EnableIlluminate = true,
        EnableScrollView = true,
        EnableIndentBlankline = true,
        EnableLeap = true,
        IndentBlacklinePreset = "BlinkIndent",
    },
    FullEditor = {
        EnableNeoTree = true,
        EnableBufferLine = false,
        EnableLualine = true,
        EnableLayout = false,
        EnableDropbar = true,
        EnableGrugFar = true,
        EnableEdgy = true,
        EnableTelescope = true,
        EnableTelescopeFzfNative = true,
        EnableToggleTerm = true,
        EnableCokeLine = true,
    },
    LanguageServerProtocol = {
        EnableBlinkCmp = true,
        EnableNVimCmp = false,
        EnableLuaSnip = true,
        EnableFirendlySnippets = true,
        EnableFridget = true,
        EnableTrouble = true,
        EnableNVimLint = true,
    },
    Formatter = {
        EnableConform = true,
        FormaterToInstall = {},
    },
    PackageManager = {
        EnableMeson = true,
    },
    Treesitter = {
        EnableNVimTreesitter = true,
        EnableNVimTsCommentstring = true,
        NVimTsCommentStringPreset = "NvimTsContextCommentstring",
        EnableNVimTreesitterTextobject = true,
    },
    Themes = {
        EnableCatppuccin = true,
        EnableDashboard = true,
        EnableMenu = true,
        EnableLiteUi = true,
        EnableVimQuickUi = false,
        DashboardPlugin = "ProfileNVim",
    },
    Extras = {
        EnableCAndCpp = false,
    },
}
M.Presets.Default = PresetDefault

---@type IceThorn.PluginList
local PresetLuaOnly = vim.tbl_deep_extend("force", M.PrivateFunction.Clone(PresetDefault), {
    ---@type IceThorn.PluginList.Editor
    Editor = {
        EnableImage = false,
        EnableIndentBlankline = true,
        IndentBlacklinePreset = "Hlchunk",
    },
    ---@type IceThorn.PluginList.FullEditor
    FullEditor = {
        EnableTelescopeFzfNative = false,
    },
    ---@type IceThorn.PluginList.LanguageServerProtocol
    LanguageServerProtocol = {
        EnableBlinkCmp = false,
        EnableNVimCmp = true,
    },
})
M.Presets.LuaOnly = PresetLuaOnly
---@type IceThorn.PluginList
local PresetNone = vim.tbl_extend("force", PresetDefault, {
    Preset = "None",
    Editor = M.PrivateFunction.Table.ChangeValue(PresetDefault.Editor, "boolean", false, { CloneObject = true }),
    FullEditor = M.PrivateFunction.Table.ChangeValue(
        PresetDefault.FullEditor,
        "boolean",
        false,
        { CloneObject = true }
    ),
    LanguageServerProtocol = M.PrivateFunction.Table.ChangeValue(
        PresetDefault.LanguageServerProtocol,
        "boolean",
        false,
        { CloneObject = true }
    ),
    Formater = M.PrivateFunction.Table.ChangeValue(PresetDefault.Formatter, "boolean", false, { CloneObject = true }),
    PackageManager = M.PrivateFunction.Table.ChangeValue(
        PresetDefault.PackageManager,
        "boolean",
        false,
        { CloneObject = true }
    ),
    Themes = M.PrivateFunction.Table.ChangeValue(PresetDefault.Themes, "boolean", false, { CloneObject = true }),
    Treesitter = M.PrivateFunction.Table.ChangeValue(
        PresetDefault.Treesitter,
        "boolean",
        false,
        { CloneObject = true }
    ),
})
local range = require("LuaLibrary").List.Range
M.Presets.None = PresetNone
local PresetVsCode = vim.tbl_deep_extend("force", PresetNone, {
    Preset = "VsCode",
    Editor = M.PrivateFunction.Clone(PresetDefault.Editor),
    Treesitter = M.PrivateFunction.Clone(PresetDefault.Treesitter),
    Themes = M.PrivateFunction.Clone(PresetDefault.Themes),
    LanguageServerProtocol = M.PrivateFunction.Clone(PresetDefault.LanguageServerProtocol),
    PackageManager = M.PrivateFunction.Clone(PresetDefault.PackageManager),
})

M.Presets.VsCode = PresetNone
---@param PluginOptions IceThorn.PluginList
---@param ...           IceThorn.VimPack.Specs
M.Load = function(PluginOptions, ...)
    if PluginOptions == nil then
        PluginOptions = PresetDefault
    elseif PluginOptions.Preset == "Default" or PluginOptions.Preset == nil then
        PluginOptions = vim.tbl_deep_extend("force", PresetDefault, PluginOptions)
    elseif PluginOptions.Preset == "LuaOnly" then
        PluginOptions = vim.tbl_deep_extend("force", PresetLuaOnly, PluginOptions)
    elseif PluginOptions.Preset == "VsCode" then
        PluginOptions = vim.tbl_deep_extend("force", PresetVsCode, PluginOptions)
    elseif PluginOptions.Preset == "None" then
        PluginOptions = vim.tbl_deep_extend("force", PresetNone, PluginOptions)
    end

    require("PluginManager").AddPlugins(
        M.PrivateFunction.List.Merge(
            require("Plugins.Libraries").Load(PluginOptions or {}),
            require("Plugins.Editor").Load(PluginOptions or {}),
            require("Plugins.FullEditor").Load(PluginOptions or {}),
            require("Plugins.PackageManager").Load(PluginOptions or {}),
            require("Plugins.Formatter").Load(PluginOptions or {}),
            require("Plugins.LanguageServerProtocol").Load(PluginOptions or {}),
            require("Plugins.Treesitter").Load(PluginOptions or {}),
            require("Plugins.Themes").Load(PluginOptions or {}),
            require("Plugins.Extras.Language.CAndCpp").Load(PluginOptions or {}),
            ...
        )
    )
end
return M
