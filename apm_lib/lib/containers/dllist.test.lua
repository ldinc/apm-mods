local dllist = require("dllist")

function test()
	local list = dllist.new()

	-- ... (previous tests 1-10 remain unchanged) ...

	-- Test 11: Circular navigation (get_next_loop)
	dllist.reset(list)

	-- Test on empty list
	local v, id = dllist.get_next_loop(list)
	assert(v == nil and id == nil, "Test11.1 empty list")

	-- Test single item list
	dllist.add(list, "A", 10)
	dllist.get_head(list)

	-- Should stay on A when getting next in loop
	local v11, id11 = dllist.get_next_loop(list)
	assert(v11 == 10 and id11 == "A", "Test11.2 single item loop")

	-- Add more items
	dllist.add(list, "B", 20)
	dllist.add(list, "C", 30)

	-- Start at head (A)
	dllist.get_head(list)

	-- First next: A -> B
	local v12, id12 = dllist.get_next_loop(list)
	assert(v12 == 20 and id12 == "B", "Test11.3 first next")

	-- Second next: B -> C
	local v13, id13 = dllist.get_next_loop(list)
	assert(v13 == 30 and id13 == "C", "Test11.4 second next")

	-- Third next: C -> A (wrap around)
	local v14, id14 = dllist.get_next_loop(list)
	assert(v14 == 10 and id14 == "A", "Test11.5 wrap to head")

	-- Fourth next: A -> B
	local v15, id15 = dllist.get_next_loop(list)
	assert(v15 == 20 and id15 == "B", "Test11.6 after wrap")

	-- Test from tail
	dllist.get_tail(list)                       -- Now at C
	local v16, id16 = dllist.get_next_loop(list) -- C -> A
	assert(v16 == 10 and id16 == "A", "Test11.7 from tail")

	-- Test after removal
	dllist.remove(list, "B")
	dllist.get_head(list)                       -- At A
	dllist.get_next_loop(list)                  -- A -> C
	local v17, id17 = dllist.get_next_loop(list) -- C -> A
	assert(v17 == 10 and id17 == "A", "Test11.8 after removal")

	-- Test with one item after removals
	dllist.remove(list, "A")
	dllist.get_head(list)                       -- At C
	local v18, id18 = dllist.get_next_loop(list) -- C -> C
	assert(v18 == 30 and id18 == "C", "Test11.9 single item after removal")

	print("All tests passed!")
end

test()
