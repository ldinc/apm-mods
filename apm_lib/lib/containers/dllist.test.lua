---@diagnostic disable-next-line: different-requires
local dllist = require("dllist")

---NOTE: Partially generated with DeepseekAI

function test()
	local list = dllist.new()

	-- Initial count
	assert(dllist.length(list) == 0, "Initial count should be 0")

	-- Test 1: Add and get head
	dllist.add(list, "A", 10)
	assert(dllist.length(list) == 1, "Test1 count after add")

	-- Test find on existing item
	local found_val, found_ok = dllist.find(list, "A")
	assert(found_val == 10 and found_ok == true, "Test1 find")

	local hv, hid = dllist.get_head(list)
	local cv, cid = dllist.get_current(list)
	assert(hv == 10 and hid == "A", "Test1 head")
	assert(cv == 10 and cid == "A", "Test1 current")

	-- Test 2: Add more items
	dllist.add(list, "B", 20)
	dllist.add(list, "C", 30)
	assert(dllist.length(list) == 3, "Test2 count after adds")

	-- Test find on multiple items
	assert(dllist.find(list, "B") == 20, "Test2 find B")
	assert(dllist.find(list, "C") == 30, "Test2 find C")

	local tv, tid = dllist.get_tail(list)
	assert(tv == 30 and tid == "C", "Test2 tail")

	-- Test 3: Navigation (shouldn't affect count)
	dllist.get_head(list)
	local n1v, n1id = dllist.get_next(list)
	assert(n1v == 20 and n1id == "B", "Test3.1 next")
	assert(dllist.length(list) == 3, "Test3.1 count unchanged")
	local n2v, n2id = dllist.get_next(list)
	assert(n2v == 30 and n2id == "C", "Test3.2 next")
	assert(dllist.length(list) == 3, "Test3.2 count unchanged")
	local n3v, n3id = dllist.get_next(list)
	assert(n3v == nil and n3id == nil, "Test3.3 next")
	assert(dllist.length(list) == 3, "Test3.3 count unchanged")

	-- Test 4: Removal
	dllist.remove(list, "B")
	assert(dllist.length(list) == 2, "Test4 count after removal")

	-- Test find after removal
	local val, ok = dllist.find(list, "B")
	assert(val == nil and ok == false, "Test4 find after removal")

	dllist.get_head(list)
	local c4v, c4id = dllist.get_current(list)
	assert(c4v == 10 and c4id == "A", "Test4.1 current")
	local n4v, n4id = dllist.get_next(list)
	assert(n4v == 30 and n4id == "C", "Test4.2 next")

	-- Test 5: Current pointer safety
	dllist.get_head(list)
	dllist.remove(list, "A")
	assert(dllist.length(list) == 1, "Test5 count after removal")

	-- Test find on removed item
	assert(dllist.find(list, "A") == nil, "Test5 find removed")

	local c5v, c5id = dllist.get_current(list)
	assert(c5v == 30 and c5id == "C", "Test5 current")

	-- Test 6: Edge cases
	dllist.remove(list, "C")
	assert(dllist.length(list) == 0, "Test6 count after removal")

	-- Test find on empty list
	assert(dllist.find(list, "C") == nil, "Test6 find on empty")

	local h6v = dllist.get_head(list)
	assert(h6v == nil, "Test6 head")
	local t6v = dllist.get_tail(list)
	assert(t6v == nil, "Test6 tail")
	assert(dllist.remove(list, "X") == false, "Test6 remove")
	assert(dllist.length(list) == 0, "Test6 count after failed remove")

	-- Test 7: ID conflict
	local ok = dllist.add(list, "A", 100)
	assert(ok == true, "Test7 first add")
	assert(dllist.length(list) == 1, "Test7 count after first add")

	-- Test find after conflict add
	assert(dllist.find(list, "A") == 100, "Test7 find after add")

	local conflict_ok = dllist.add(list, "A", 200)
	assert(conflict_ok == false, "Test7 conflict")
	assert(dllist.length(list) == 1, "Test7 count unchanged after conflict")

	-- Test 8: Multiple sequential operations
	dllist.add(list, "B", 200)
	dllist.add(list, "C", 300)
	assert(dllist.length(list) == 3, "Test8 count after adds")

	-- Test find on all items
	assert(dllist.find(list, "A") == 100, "Test8 find A")
	assert(dllist.find(list, "B") == 200, "Test8 find B")
	assert(dllist.find(list, "C") == 300, "Test8 find C")

	dllist.remove(list, "A")
	dllist.remove(list, "C")
	assert(dllist.length(list) == 1, "Test8 count after removals")

	-- Test find after removals
	assert(dllist.find(list, "A") == nil, "Test8 find removed A")
	assert(dllist.find(list, "C") == nil, "Test8 find removed C")
	assert(dllist.find(list, "B") == 200, "Test8 find remaining B")

	dllist.add(list, "D", 400)
	assert(dllist.length(list) == 2, "Test8 count after new add")

	-- Test find on new item
	assert(dllist.find(list, "D") == 400, "Test8 find new item")

	-- Test 9: Find non-existent item
	assert(dllist.find(list, "X") == nil, "Test9 find non-existent")
	assert(dllist.find(list, nil) == nil, "Test9 find nil")
	assert(dllist.find(list, 123) == nil, "Test9 find number")

	-- Test 10: Reset functionality
	dllist.reset(list)
	assert(dllist.length(list) == 0, "Test10 count after reset")
	assert(dllist.get_head(list) == nil, "Test10 head after reset")
	assert(dllist.get_tail(list) == nil, "Test10 tail after reset")
	assert(dllist.get_current(list) == nil, "Test10 current after reset")
	assert(dllist.find(list, "B") == nil, "Test10 find B after reset")
	assert(dllist.find(list, "D") == nil, "Test10 find D after reset")

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
