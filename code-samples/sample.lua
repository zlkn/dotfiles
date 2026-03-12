-- Lua — syntax sampler
--[[ block comment ]]
local M = {}
local Color = { RED = 1, GREEN = 2, BLUE = 3 }

local function distance(a, b)
    local dx, dy = a.x - b.x, a.y - b.y
    return (dx * dx + dy * dy) ^ 0.5
end

M.Point = {
    __index = function(t, k)
        return rawget(t, k) or 0
    end,
}
function M.Point:new(x, y)
    local o = setmetatable({ x = x or 0, y = y or 0 }, self)
    return o
end

local fmt = string.format
local msg = ([[color: %s → %.2f]]):gsub("color", "color"):gsub("%s", " ")
local p = M.Point:new(0, 1)
local q = M.Point:new(2, 3)

local ok, res = pcall(function()
    local d = distance(p, q)
    return { label = "dist", value = d, color = Color.RED }
end)

for k, v in pairs(ok and res or {}) do
    print(fmt("%s = %s", k, tostring(v)))
end

-- pattern match (not full regex)
local s = "hello-world"
if s:match("^hello[%s%-]*world$") then
    print(msg:format("RED", distance(p, q)))
end

return M
