---@diagnostic disable-next-line: different-requires
local e_strings = require("strings")

---NOTE: Partially generated with DeepseekAI

-- Test runner function
local function run_tests()
	local tests = {
		{
			name = "Basic comma-separated values",
			input = { str = "a,b,c", pattern = "," },
			expected = { "a", "b", "c" }
		},
		{
			name = "Whitespace removal and strings.split_by_pattern",
			input = { str = " 1 , 2 , 3 ", pattern = "," },
			expected = { "1", "2", "3" }
		},
		{
			name = "Leading delimiter (comma)",
			input = { str = ",a,b", pattern = "," },
			expected = { "a", "b" }
		},
		{
			name = "Trailing delimiter (comma)",
			input = { str = "a,b,", pattern = "," },
			expected = { "a", "b" }
		},
		{
			name = "Consecutive delimiters (comma)",
			input = { str = "a,,b", pattern = "," },
			expected = { "a", "", "b" }
		},
		{
			name = "Two consecutive delimiters",
			input = { str = ",,", pattern = "," },
			expected = { "" }
		},
		{
			name = "Three consecutive delimiters",
			input = { str = ",,,", pattern = "," },
			expected = { "", "" }
		},
		{
			name = "Empty input string",
			input = { str = "", pattern = "," },
			expected = {}
		},
		{
			name = "Whitespace-only input",
			input = { str = "   ", pattern = "," },
			expected = {}
		},
		{
			name = "No delimiters found",
			input = { str = "abc", pattern = "," },
			expected = { "abc" }
		},
		{
			name = "Pattern with digits (split on number)",
			input = { str = "a1b2c", pattern = "%d" },
			expected = { "a", "b", "c" }
		},
		{
			name = "Pattern with literal dot",
			input = { str = "a.b.c", pattern = "%." },
			expected = { "a", "b", "c" }
		}
	}

	-- Tests for split_by_pattern
	print("Testing split_by_pattern")
	for _, test in ipairs(tests) do
		local result = e_strings.split_by_pattern(test.input.str, test.input.pattern)
		local passed = true
		if #result ~= #test.expected then
			passed = false
		else
			for i = 1, #result do
				if result[i] ~= test.expected[i] then
					passed = false
					break
				end
			end
		end

		if passed then
			print(string.format("PASSED: %s", test.name))
		else
			print(string.format("FAILED: %s", test.name))
			print("  Input:    " .. string.format("%q, %q", test.input.str, test.input.pattern))
			print("  Expected: " .. table.concat(test.expected, ", "))
			print("  Result:   " .. table.concat(result, ", "))
		end
	end

	-- Tests for split_by_pattern_to_dict
	print("\nTesting split_by_pattern_to_dict")
	for _, test in ipairs(tests) do
		local dict, list = e_strings.split_by_pattern_to_dict(test.input.str, test.input.pattern)

		-- Verify list part matches expected
		local list_ok = true
		if #list ~= #test.expected then
			list_ok = false
		else
			for i = 1, #list do
				if list[i] ~= test.expected[i] then
					list_ok = false
					break
				end
			end
		end

		-- Verify dictionary contains all keys from list
		local dict_ok = true
		for _, key in ipairs(list) do
			if dict[key] ~= true then
				dict_ok = false
				break
			end
		end

		if list_ok and dict_ok then
			print(string.format("PASSED: %s", test.name))
		else
			print(string.format("FAILED: %s", test.name))
			if not list_ok then
				print("  List part mismatch")
				print("  Expected: " .. table.concat(test.expected, ", "))
				print("  Actual:   " .. table.concat(list, ", "))
			end
			if not dict_ok then
				print("  Dictionary missing key(s) from list")
			end
		end
	end
end

-- Execute tests
run_tests()
