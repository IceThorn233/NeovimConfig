local API = {}

---@param ... any
function API.PrintObject(...)
    for _, obj in ipairs({ ... }) do
        print(require("LuaLibrary.string").ObjectToJsonString(obj))
    end
end

---@generic T
---@param Obj T
---@return T
function API.Clone(Obj)
    if type(Obj) == "table" then
        local cloneObject = {}
        for k, v in pairs(Obj) do
            k = API.Clone(k)
            cloneObject[k] = API.Clone(v)
        end
        return setmetatable(cloneObject, getmetatable(Obj))
    else
        return Obj
    end
end

return API
