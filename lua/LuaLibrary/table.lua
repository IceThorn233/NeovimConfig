local API = {}
API.Clone = require("LuaLibrary.none").Clone

---@class IceThorn.Library.ChangeValue.Behavior
---@field CloneObject? boolean

---@generic T
---@param Obj T
---@param Filter type | fun(k:any,v:T):boolean
---@param Value any
---@param Behavior? IceThorn.Library.ChangeValue.Behavior
---@return T
function API.ChangeValue(Obj, Filter, Value, Behavior)
    if type(Obj) ~= "table" then
        return Obj
    end
    if Behavior and Behavior.CloneObject then
        Obj = API.Clone(Obj)
    end
    for key, value in pairs(Obj) do
        if type(Filter) == "string" then
            if type(value) == Filter then
                if Behavior and Behavior.CloneObject then
                    Value = API.Clone(Value)
                end
                Obj[key] = Value
            end
        elseif type(Filter) == "function" then
            if not Filter(key, value) then
                if Behavior and Behavior.CloneObject then
                    Value = API.Clone(Value)
                end
                Obj[key] = Value
            end
        end
    end
    return Obj
end

---Merges two or more tables recursively.
---@generic T:table?
---@param Behavior "Keep" | "Force"
---@param ... T
---@return T
function API.TableDeepExtend(Behavior, ...)
    local result = {}
    for _, Item in ipairs({ ... }) do
        if Item ~= nil and type(Item) == "table" then
            Item = API.Clone(Item)
            for Key, Value in pairs(Item) do
                if result[Key] ~= nil then
                    if Behavior == "Force" then
                        result[Key] = Value
                    end
                else
                    result[Key] = Value
                end
            end
        end
    end
    return result
end
return API
