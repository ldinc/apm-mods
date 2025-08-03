local dllist = require("dllist")

function test()
	local list = dllist.new()

	-- ... (previous tests 1-10 remain unchanged) ...

	-- Test 11: Circular navigation (get_next_loop)
	list:reset()

	-- Test on empty list
	local v, id = list:get_next_loop()
	assert(v == nil and id == nil, "Test11.1 empty list")

	-- Test single item list
	list:add("A", 10)
	list:get_head()

	-- Should stay on A when getting next in loop
	local v11, id11 = list:get_next_loop()
	assert(v11 == 10 and id11 == "A", "Test11.2 single item loop")

	-- Add more items
	list:add("B", 20)
	list:add("C", 30)

	-- Start at head (A)
	list:get_head()

	-- First next: A -> B
	local v12, id12 = list:get_next_loop()
	assert(v12 == 20 and id12 == "B", "Test11.3 first next")

	-- Second next: B -> C
	local v13, id13 = list:get_next_loop()
	assert(v13 == 30 and id13 == "C", "Test11.4 second next")

	-- Third next: C -> A (wrap around)
	local v14, id14 = list:get_next_loop()
	assert(v14 == 10 and id14 == "A", "Test11.5 wrap to head")

	-- Fourth next: A -> B
	local v15, id15 = list:get_next_loop()
	assert(v15 == 20 and id15 == "B", "Test11.6 after wrap")

	-- Test from tail
	list:get_tail()                       -- Now at C
	local v16, id16 = list:get_next_loop() -- C -> A
	assert(v16 == 10 and id16 == "A", "Test11.7 from tail")

	-- Test after removal
	list:remove("B")
	list:get_head()                       -- At A
	list:get_next_loop()                  -- A -> C
	local v17, id17 = list:get_next_loop() -- C -> A
	assert(v17 == 10 and id17 == "A", "Test11.8 after removal")

	-- Test with one item after removals
	list:remove("A")
	list:get_head()                       -- At C
	local v18, id18 = list:get_next_loop() -- C -> C
	assert(v18 == 30 and id18 == "C", "Test11.9 single item after removal")

	print("All tests passed!")
end

test()
