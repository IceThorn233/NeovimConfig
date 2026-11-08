---@alias IceThorn.VimPack.PluginSpec.InitializationFunction fun(Overwrite?:table?,EventArguments?:vim.api.keyset.create_autocmd.callback_args)
---@alias IceThorn.VimPack.Spec IceThorn.VimPack.PluginSpec | string
---@alias IceThorn.VimPack.Specs (IceThorn.VimPack.PluginSpec | string)[]

---@class IceThorn.VimPack.PluginSpec
---@field Name?      string
---@field Condition? boolean
---@field Source     IceThorn.VimPack.PluginSpec.Source | string
---@field Configura? IceThorn.VimPack.PluginSpec.Configura | IceThorn.VimPack.PluginSpec.InitializationFunction
---@field Overwrite? table

---@alias IceThorn.VimPack.PluginSpec.Configura.Event vim.api.keyset.events | vim.api.keyset.events[] | "Null"

---@class IceThorn.VimPack.PluginSpec.Configura
---@field LazyLoadEvent?  IceThorn.VimPack.PluginSpec.Configura.Event
---@field Initialization? IceThorn.VimPack.PluginSpec.InitializationFunction

---@class IceThorn.VimPack.PluginSpec.Source
---@field Url      string
---@field Version? string | vim.VersionRange
---@field Type?    "Raw" | "Github" | "Codeberg" | "GithubProxy"

---@class IceThorn.VimPack.PrivatePlugSpec
---@field Url             string
---@field Overwrite       table?
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
local lib = require("LuaLibrary")
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
    vim.api.nvim_create_user_command("VimPackList", function()
        lib.PrintObject(vim.pack.get())
    end, {})
    vim.api.nvim_create_user_command("VimPackUpdate", function()
        vim.pack.update()
    end, {})
end

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

---@param PluginSpecs IceThorn.VimPack.Spec[]
function M.AddPlugins(PluginSpecs)
    if PluginSpecs == nil then
        return
    end
    ---@type table<(vim.api.keyset.events | "Null"),string[]>
    local eventUrlMap = {}
    ---@type table<string,IceThorn.VimPack.PluginSpec.InitializationFunction?>
    local pluginInitializationFunction = {}
    ---@type table<string,boolean>
    local pluginLoaded = {}
    ---@type table<string,table?>
    local pluginOverwrite = {}
    ---@type table<string,vim.pack.Spec>
    local pluginSpecs = {}

    for _, item in ipairs(PluginSpecs) do
        if type(item) == "string" then
            pluginSpecs[item] = {
                src = item,
            }
        elseif type(item) == "table" then
            local pluginSpec = ps(item.Source, item.Name)
            if item.Overwrite ~= nil then
                pluginOverwrite[pluginSpec.src] =
                    lib.Table.TableDeepExtend("Force", pluginOverwrite[pluginSpec.src] or {}, item.Overwrite or {})
            elseif item.Condition ~= false then
                pluginSpecs[pluginSpec.src] = pluginSpec
                pluginLoaded[pluginSpec.src] = false
                if type(item.Configura) == "function" then
                    eventUrlMap["Null"] = eventUrlMap["Null"] or {}
                    table.insert(eventUrlMap["Null"], pluginSpec.src)
                    pluginInitializationFunction[pluginSpec.src] = item.Configura
                elseif type(item.Configura) == "table" and item.Configura.LazyLoadEvent ~= nil then
                    if type(item.Configura.LazyLoadEvent) == "string" then
                        local event = item.Configura.LazyLoadEvent
                        eventUrlMap[event] = eventUrlMap[event] or {}
                        table.insert(eventUrlMap[event], pluginSpec.src)
                    elseif type(item.Configura.LazyLoadEvent) == "table" then
                        for _, event in ipairs(item.Configura.LazyLoadEvent) do
                            eventUrlMap[event] = eventUrlMap[event] or {}
                            table.insert(eventUrlMap[event], pluginSpec.src)
                        end
                    end
                    pluginInitializationFunction[pluginSpec.src] = item.Configura.Initialization
                elseif type(item.Configura) == "table" and item.Configura.LazyLoadEvent == nil then
                    local event = "Null"
                    eventUrlMap[event] = eventUrlMap[event] or {}
                    table.insert(eventUrlMap[event], pluginSpec.src)
                    pluginInitializationFunction[pluginSpec.src] = item.Configura.Initialization
                end
            end
        end
    end
    do
        local specs = {}
        for _, spec in pairs(pluginSpecs) do
            table.insert(specs, spec)
        end
        vim.pack.add(specs)
    end
    for event, pluginUrls in pairs(eventUrlMap) do
        if event == "Null" then
            for _, pluginUrl in ipairs(pluginUrls) do
                local initializationFunction = pluginInitializationFunction[pluginUrl]
                if initializationFunction ~= nil then
                    initializationFunction(pluginOverwrite[pluginUrl], nil)
                    pluginInitializationFunction[pluginUrl] = nil
                    pluginLoaded[pluginUrl] = true
                end
            end
        elseif event ~= "Null" then
            vim.api.nvim_create_autocmd(event, {
                callback = function(callbackArguments)
                    for _, pluginUrl in ipairs(pluginUrls) do
                        local initializationFunction = pluginInitializationFunction[pluginUrl]
                        if initializationFunction ~= nil then
                            initializationFunction(pluginOverwrite[pluginUrl], callbackArguments)
                            pluginInitializationFunction[pluginUrl] = nil
                            pluginLoaded[pluginUrl] = true
                        end
                    end
                end,
            })
        end
    end
end

return M
