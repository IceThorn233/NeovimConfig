local API = {
    Range = {},
}

---@generic T
---@type fun(o:T):T
API.Clone = require("LuaLibrary.none").Clone

---@generic T
---@param ... T[]
---@return T[]
function API.Merge(...)
    local Result = {}
    for _, Array in ipairs({ ... }) do
        for _, Item in ipairs(Array) do
            table.insert(Result, API.Clone(Item))
        end
    end
    return Result
end

---@param o any
---@return boolean
function API.IsList(o)
    if type(o) == "table" then
        local prevKey = 0
        for k, _ in pairs(o) do
            if type(k) ~= "number" then
                return false
            end
            if (k - 1) == prevKey then
                prevKey = k
            else
                return false
            end
        end
        return true
    else
        return false
    end
end

---@param first integer
---@param last integer
---@return integer[]
function API.Iota(first, last)
    local result = {}
    for i = first, last do
        table.insert(result, i)
    end
    return result
end

---@param first integer
---@param last integer
---@return fun():integer?
function API.IotaIter(first, last)
    first = first - 1
    return function()
        first = first + 1
        if first <= last then
            return first
        end
    end
end

---@generic TInput
---@generic TOutput
---@param list TInput[]
---@param fun fun(i:TInput):TOutput?
---@return (TOutput)[]
function API.Foreach(list, fun)
    local result = {}
    for _, o in ipairs(list) do
        table.insert(result, fun(o))
    end
    return result
end

---@generic TInput
---@param list TInput[]
---@param fun fun(i:TInput):boolean
---@return TInput[]
function API.Filter(list, fun)
    local result = {}
    for _, o in ipairs(list) do
        if fun(o) then
            table.insert(result, o)
        end
    end
    return result
end

---@alias IceThorn.Library.Range.Transform<TItem,TOutputItem> fun(item:TItem):TOutputItem
---@alias IceThorn.Library.Range.Filter<TItem> fun(item:TItem):boolean

---@class IceThorn.Library.Range<TItem>
---@field Transform fun<TOutputItem>(obj:IceThorn.Library.Range<TItem>,operation:IceThorn.Library.Range.Transform<TItem,TOutputItem>):IceThorn.Library.Range<TOutputItem>
---@field Filter fun(obj:IceThorn.Library.Range<TItem>,operation:IceThorn.Library.Range.Filter<TItem>):IceThorn.Library.Range<TItem>
---@field FilterByType fun(obj:IceThorn.Library.Range<TItem>,type:type):IceThorn.Library.Range<TItem>
---@field Tack fun(obj:IceThorn.Library.Range<TItem>,n:integer):IceThorn.Library.Range<TItem>
---@field Unpack fun(obj:IceThorn.Library.Range<TItem>):TItem[]
---@field Join fun(...:IceThorn.Library.Range<TItem>):IceThorn.Library.Range<TItem>
---@field transform fun<TSourceItem>(o:TSourceItem,i:integer):TItem
---@operator call:TItem[]
---@operator concat(IceThorn.Library.Range<TItem>):IceThorn.Library.Range<TItem>

---@generic TItem
---@generic TOutputItem
---@param obj IceThorn.Library.Range<TItem>
---@param operation IceThorn.Library.Range.Transform<TItem,TOutputItem>
---@return IceThorn.Library.Range<TOutputItem>
function API.Range.Transform(obj, operation)
    obj = API.Clone(obj)
    local oTransform = obj.transform
    obj.transform = function(item, index)
        item = oTransform(item, index)
        if item ~= nil then
            return operation(item)
        else
            return nil
        end
    end
    return obj
end

---@generic TItem
---@param obj IceThorn.Library.Range<TItem>
---@param operation IceThorn.Library.Range.Filter<TItem>
---@return IceThorn.Library.Range<TItem>
function API.Range.Filter(obj, operation)
    obj = API.Clone(obj)
    local oTransform = obj.transform
    obj.transform = function(o, i)
        local cache = oTransform(o, i)
        return operation(cache) and cache or nil
    end
    return obj
end

---@generic TItem
---@param obj IceThorn.Library.Range<TItem>
---@param targetType type
---@return IceThorn.Library.Range<TItem>
function API.Range.FilterByType(obj, targetType)
    obj = API.Clone(obj)
    local oTransform = obj.transform
    obj.transform = function(o, i)
        local cache = oTransform(o, i)
        if cache ~= nil and type(cache) == targetType then
            return cache
        else
            return nil
        end
    end
    return obj
end
---@generic TItem
---@param obj IceThorn.Library.Range<TItem>
---@param n integer
---@return IceThorn.Library.Range<TItem>
function API.Range.Tack(obj, n)
    obj = API.Clone(obj)
    local oTransform = obj.transform
    obj.transform = function(o, i)
        return i <= n and oTransform(o, i) or nil
    end
    return obj
end

---@generic TItem
---@param _ IceThorn.Library.Range<TItem>
---@return TItem[]
function API.Range.EmptyUnpack(_)
    return {}
end

---@generic TItem
---@param ... IceThorn.Library.Range<TItem>
---@return IceThorn.Library.Range<TItem>
function API.Range.Join(...)
    local result = API.Range.NewEmpty()
    local ranges = API.Clone({ ... })
    result.Unpack = function()
        local r = {}
        for _, range in ipairs(ranges) do
            for _, item in ipairs(range:Unpack()) do
                table.insert(r, item)
            end
        end
        return r
    end
    return result
end

---@generic TItem
---@return IceThorn.Library.Range<TItem>
function API.Range.NewEmpty()
    ---@type IceThorn.Library.Range<any>
    local result = {
        Transform = API.Range.Transform,
        Filter = API.Range.Filter,
        FilterByType = API.Range.FilterByType,
        Tack = API.Range.Tack,
        Unpack = API.Range.EmptyUnpack,
        Join = API.Range.Join,
        transform = function(s, _)
            return s
        end,
    }
    setmetatable(result, {
        __call = function(obj)
            return obj:Unpack()
        end,
        __concat = function(lsh, rsh)
            local r = API.Range.NewEmpty()
            r.Unpack = function()
                return API.Merge(lsh(), rsh())
            end
            return r
        end,
    })
    return result
end

---@generic TItem
---@param ... TItem
---@return IceThorn.Library.Range<TItem>?
function API.Range.Pack(...)
    return API.Range.New({ ... })
end

---@generic TItem
---@param list TItem[] | fun():TItem
---@return IceThorn.Library.Range<TItem>
function API.Range.New(list)
    list = API.Clone(list)
    local result = API.Range.NewEmpty()
    if type(list) == "function" then
        function result:Unpack()
            local unpackResult = {}
            local index = 0
            for item in list do
                index = index + 1
                table.insert(unpackResult, self.transform(item, index))
            end
            return unpackResult
        end
    elseif API.IsList(list) then
        function result:Unpack()
            local unpackResult = {}
            for i, o in ipairs(list) do
                local cache = self.transform(o, i)
                if cache ~= nil then
                    table.insert(unpackResult, cache)
                end
            end
            return unpackResult
        end
    end
    return result
end

return API
