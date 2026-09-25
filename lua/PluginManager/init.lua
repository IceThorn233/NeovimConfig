---@alias IceThorn.VimPack.PluginSpec.InitializationFunction fun(EventArguments?:vim.api.keyset.create_autocmd.callback_args)
---@alias IceThorn.VimPack.Spec IceThorn.VimPack.PluginSpec | string
---@alias IceThorn.VimPack.Specs (IceThorn.VimPack.PluginSpec | string)[]

---@class IceThorn.VimPack.PluginSpec
---@field Name?      string
---@field Condition? boolean
---@field Source     IceThorn.VimPack.PluginSpec.Source | string
---@field Configura? IceThorn.VimPack.PluginSpec.Configura | IceThorn.VimPack.PluginSpec.InitializationFunction
---@field Overwrite? table

---@alias IceThorn.VimPack.PluginSpec.Configura.Event vim.api.keyset.events | vim.api.keyset.events[] | "VimPackNow"

---@class IceThorn.VimPack.PluginSpec.Configura
---@field LazyLoadEvent?  IceThorn.VimPack.PluginSpec.Configura.Event
---@field Initialization? IceThorn.VimPack.PluginSpec.InitializationFunction

---@class IceThorn.VimPack.PluginSpec.Source
---@field Url      string
---@field Version? string | vim.VersionRange
---@field Type?    "Raw" | "Github" | "Codeberg" | "GithubProxy"

---@class IceThorn.VimPack.PrivatePlugSpec
---@field Url             string
---@field Initialization? IceThorn.VimPack.PluginSpec.InitializationFunction

---@class IceThorn.VimPack.Options
---@field ForceGithubProxy?      boolean
---@field ForceImmediateLoading? boolean

---@class IceThorn.VimPack
local M = {
    ---@type IceThorn.VimPack.Options
    GobalOptions = {
        ---@type boolean
        ForceGithubProxy = false,
        ForceImmediateLoading = false,
    },
    Private = {},
    ---@type table<string, boolean>
    LoadedPluginSpecs = {},

    ---@type boolean
    IsInitialized = false,
}

---@class IceThorn.VimPack.PluginStatus
---@field Name        string
---@field Source      string
---@field IsActivable boolean
---@field IsLoaded    boolean

---@type fun(i: vim.pack.PlugData): IceThorn.VimPack.PluginStatus
---@param i vim.pack.PlugData
---@return IceThorn.VimPack.PluginStatus
M.Convert = function(i)
    ---@type IceThorn.VimPack.PluginStatus
    return {
        Name = i.spec.name,
        Source = i.spec.src,
        IsActivable = i.active,
        IsLoaded = M.LoadedPluginSpecs[i.spec.src] or false,
    }
end

---@type fun(Options?: IceThorn.VimPack.Options)
---@param Options? IceThorn.VimPack.Options
M.Setup = function(Options)
    -- TODO: Create command.
    if M.IsInitialized then
        return
    end
    M.GobalOptions = vim.tbl_deep_extend("force", {}, M.GobalOptions, Options or {})
    vim.api.nvim_create_user_command("VimPackList", function() end, {})
    vim.api.nvim_create_user_command("VimPackUpdate", function()
        vim.pack.update()
    end, {})
end

-- print_r(vim.version.range("1.*"))
-- print(type(vim.version.range("1.*")))
-- local ps = require("PluginManager.ProcessSource").ProcessSource
---@param Source IceThorn.VimPack.PluginSpec.Source | string
---@param Name   string?
---@return vim.pack.Spec
local ps = function(Source, Name)
    ---@type string
    local Url
    ---@type "Raw" | "Github" | "Codeberg" | "GithubProxy"
    local Type
    ---@type (vim.VersionRange | string)?
    local version
    if type(Source) == "string" then
        Type = "Raw"
        Url = Source
    elseif type(Source) == "table" then
        Url = Source.Url
        Type = Source.Type or "Raw"
        version = Source.Version
    end

    if Type == nil or Type == "Raw" then
        Url = Url
    elseif Type == "Github" then
        Url = string.format("https://github.com/%s.git", Url)
    elseif Type == "Codeberg" then
        Url = string.format("https://codeberg/%s.git", Url)
    elseif Type == "GithubProxy" then
        Url = string.format("https://ghproxy.net/github.com/%s.git", Url)
    else
        Url = Url
        vim.notify(string.format("Invaild value:'%s' for 'ProcessSource()'"), vim.log.levels.ERROR)
    end
    ---@type vim.pack.Spec
    return { src = Url, name = Name, version = version }
end
---@param PluginSpecs IceThorn.VimPack.Specs
function M.AddPlugins(PluginSpecs)
    if PluginSpecs == nil then
        return
    end
    local VimPackSpecs = {}
    ---@type table<IceThorn.VimPack.PluginSpec.Configura.Event, IceThorn.VimPack.PrivatePlugSpec[]>
    local SetupOnEvent = {}
    -- 解析插件Specs
    for _, PluginSpec in ipairs(PluginSpecs) do
        if type(PluginSpec) == "string" then
            -- 仅URL
            local vimPackSpec = ps(PluginSpec)
            table.insert(VimPackSpecs, vimPackSpec)
            M.LoadedPluginSpecs[vimPackSpec.src] = true
        elseif type(PluginSpec) == "table" then
            -- 复杂配置
            local vimPackSpec = ps(PluginSpec.Source, PluginSpec.Name)
            ---@type IceThorn.VimPack.PrivatePlugSpec
            local privatePlugSpec = { Url = vimPackSpec.src }
            M.LoadedPluginSpecs[vimPackSpec.src] = M.LoadedPluginSpecs[vimPackSpec.src] or false
            if PluginSpec.Condition ~= false then
                if type(PluginSpec.Configura) == "function" then
                    privatePlugSpec.Initialization = PluginSpec.Configura
                    SetupOnEvent["VimPackNow"] = SetupOnEvent["VimPackNow"] or {}
                    table.insert(SetupOnEvent["VimPackNow"], privatePlugSpec)
                elseif type(PluginSpec.Configura) == "table" and PluginSpec.Configura.Initialization ~= nil then
                    local event = PluginSpec.Configura.LazyLoadEvent or "VimPackNow"
                    privatePlugSpec.Initialization = PluginSpec.Configura.Initialization
                    SetupOnEvent[event] = SetupOnEvent[event] or {}
                    table.insert(SetupOnEvent[event], privatePlugSpec)
                end
                table.insert(VimPackSpecs, vimPackSpec)
            end
        end
    end
    vim.pack.add(VimPackSpecs, {
        confirm = true,
    })
    for Event, PrivatePluginSpecs in pairs(SetupOnEvent) do
        if Event == "VimPackNow" then
            for _, privatePluginSpec in ipairs(PrivatePluginSpecs) do
                if M.LoadedPluginSpecs[privatePluginSpec.Url] ~= true then
                    M.LoadedPluginSpecs[privatePluginSpec.Url] = true
                    if privatePluginSpec.Initialization ~= nil then
                        privatePluginSpec.Initialization(nil)
                        privatePluginSpec.Initialization = nil
                    end
                    M.LoadedPluginSpecs[privatePluginSpec.Url] = true
                end
            end
        else
            vim.api.nvim_create_autocmd(Event, {
                callback = function()
                    for _, privatePluginSpec in ipairs(PrivatePluginSpecs) do
                        if M.LoadedPluginSpecs[privatePluginSpec.Url] ~= true then
                            M.LoadedPluginSpecs[privatePluginSpec.Url] = true
                            if privatePluginSpec.Initialization ~= nil then
                                privatePluginSpec.Initialization(nil)
                                privatePluginSpec.Initialization = nil
                            end
                            M.LoadedPluginSpecs[privatePluginSpec.Url] = true
                        end
                    end
                end,
            })
        end
    end
end

return M
