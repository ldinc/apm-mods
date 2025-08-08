---@param input string
---@param pattern string
---@return string[]
local function split_by_pattern(input, pattern)
	input = string.gsub(input, "%s+", "")

	local t = {}
	local fpat = "(.-)" .. pattern
	local last_end = 1
	local s, e, cap = input:find(fpat, 1)

	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(t, cap)
		end
		last_end = e + 1
		s, e, cap = input:find(fpat, last_end)
	end

	if last_end <= #input then
		cap = input:sub(last_end)
		table.insert(t, cap)
	end

	return t
end

---@param input string
---@return table<string, boolean>, string[]
local function split_by_pattern_to_dict(input, pattern)
	local list = split_by_pattern(input, pattern)

	local dict = {}

	for _, key in ipairs(list) do
		dict[key] = true
	end

	return dict, list
end

local strings = {
	split_by_pattern = split_by_pattern,
	split_by_pattern_to_dict = split_by_pattern_to_dict,
}

return strings
