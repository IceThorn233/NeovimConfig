local API = {}

---@param Source IceThorn.VimPack.PluginSpec.Source | string
---@param Name   string?
---@return vim.pack.Spec
API.ProcessSource = function(Source, Name)
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
        Type = Source.Type
        version = Source.Version
    end

    -- print_r(version)
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

return API
