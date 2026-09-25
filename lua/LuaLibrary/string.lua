local API = {}

---@param ... string
---@return string
function API.Join(...)
    local result = ""
    for _, s in ipairs({ ... }) do
        result = result .. s
    end
    return result
end

---@param obj any
---@return string
function API.ObjectToJsonString(obj)
    local List = require("LuaLibrary.list")
    if type(obj) == "nil" then
        return "null"
    elseif type(obj) == "string" then
        return API.ToJsonString(obj)
    elseif type(obj) == "boolean" then
        return obj and "true" or "false"
    elseif type(obj) == "number" then
        return tostring(obj)
    elseif type(obj) == "function" then
        local debugInfo = debug.getinfo(obj) or {}
        local paramentString = ""
        if debugInfo ~= nil then
            local paramentFormatString = ""
            debugInfo.nparams = debugInfo.nparams or 0
            if debugInfo.nparams >= 1 then
                paramentFormatString = "Parament%d"
                if debugInfo.nparams >= 2 then
                    paramentFormatString = paramentString .. (",Parament%d"):rep(debugInfo.nparams)
                end
                paramentString = paramentFormatString:format(unpack(List.Iota(1, debugInfo.nparams)))
                if debugInfo.isvararg then
                    paramentString = paramentString .. ",..."
                end
            else
                if debugInfo.isvararg then
                    paramentString = paramentString .. "..."
                end
            end
            return ('"%s(%s)"'):format(debugInfo.name or "<NamelessFunction>", paramentString)
        end
        return '"<NamelessFunction>()"'
    elseif type(obj) == "table" then
        if List.IsList(obj) then
            local isFirst = true
            local result = "["
            for _, subObject in ipairs(obj) do
                if isFirst then
                    result = result .. ("%s"):format(API.ObjectToJsonString(subObject))
                    isFirst = false
                else
                    result = result .. (",%s"):format(API.ObjectToJsonString(subObject))
                end
            end
            return result .. "]"
        else
            local isFirst = true
            local result = "{"
            for key, value in pairs(obj) do
                if isFirst then
                    result = result .. ("%s:%s"):format(API.ObjectToJsonString(key), API.ObjectToJsonString(value))
                    isFirst = false
                else
                    result = result .. (",%s:%s"):format(API.ObjectToJsonString(key), API.ObjectToJsonString(value))
                end
            end
            return result .. "}"
        end
    end
    return ('"%s"'):format(type(obj))
end

---@return string
---@param str string
function API.ToJsonString(str)
    local result = ""
    for i = 1, #str do
        local character = str:sub(i, i)
        if character == "\n" then
            result = result .. "\\n"
        elseif character == "\b" then
            result = result .. "\\b"
        elseif character == "\t" then
            result = result .. "\\t"
        elseif character == "\f" then
            result = result .. "\\f"
        elseif character == "\r" then
            result = result .. "\\r"
        elseif character == "/" then
            result = result .. "\\/"
        elseif character == '"' then
            result = result .. '\\"'
        elseif character == "\\" then
            result = result .. "\\\\"
        else
            result = result .. character
        end
    end
    return ('"%s"'):format(result)
end

return API
