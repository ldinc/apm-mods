---@diagnostic disable-next-line: different-requires
local dllist = require("dllist")

-- Unit test for containers/dllist.lua (packed-array queue).
-- Values must be tables with an `id` field; see the contract in dllist.lua.

---@param id string
---@param v integer
---@return { id: string, v: integer }
local function item(id, v)
	return { id = id, v = v }
end

---@param val { id: string, v: integer }?
---@param id string?
---@param v integer
---@param msg string
local function assert_item(val, id, v, msg)
	assert(val ~= nil and val.v == v and id ~= nil, msg)
end

---@param l DLL
---@param id string
---@return integer?
local function find_v(l, id)
	local val = dllist.find(l, id)
	---@cast val { id: string, v: integer }
	return val and val.v
end

function test()
	local list = dllist.new()

	assert(dllist.length(list) == 0, "Initial count should be 0")

	-- Test 1: Add and get head
	assert(dllist.add(list, item("A", 10)) == true, "Test1 add")
	assert(dllist.length(list) == 1, "Test1 count after add")

	local found_val, found_ok = dllist.find(list, "A")
	---@cast found_val { id: string, v: integer }
	assert(found_val ~= nil and found_val.v == 10 and found_ok == true, "Test1 find")

	local hv, hid = dllist.get_head(list)
	local cv, cid = dllist.get_current(list)
	assert_item(hv, hid, 10, "Test1 head")
	assert_item(cv, cid, 10, "Test1 current")

	-- Test 2: Add more items
	dllist.add(list, item("B", 20))
	dllist.add(list, item("C", 30))
	assert(dllist.length(list) == 3, "Test2 count after adds")

	assert(find_v(list, "B") == 20, "Test2 find B")
	assert(find_v(list, "C") == 30, "Test2 find C")

	local tv, tid = dllist.get_tail(list)
	assert_item(tv, tid, 30, "Test2 tail")

	-- Test 3: Navigation (shouldn't affect count)
	dllist.get_head(list)
	local n1v, n1id = dllist.get_next(list)
	assert_item(n1v, n1id, 20, "Test3.1 next")
	assert(dllist.length(list) == 3, "Test3.1 count unchanged")
	local n2v, n2id = dllist.get_next(list)
	assert_item(n2v, n2id, 30, "Test3.2 next")
	assert(dllist.length(list) == 3, "Test3.2 count unchanged")
	local n3v, n3id = dllist.get_next(list)
	assert(n3v == nil and n3id == nil, "Test3.3 next")
	assert(dllist.length(list) == 3, "Test3.3 count unchanged")

	-- Test 4: Removal (swap-pop relocates the tail into the freed slot)
	dllist.remove(list, "B")
	assert(dllist.length(list) == 2, "Test4 count after removal")

	local val, ok = dllist.find(list, "B")
	assert(val == nil and ok == false, "Test4 find after removal")

	dllist.get_head(list)
	local c4v, c4id = dllist.get_current(list)
	assert_item(c4v, c4id, 10, "Test4.1 current")
	local n4v, n4id = dllist.get_next(list)
	assert_item(n4v, n4id, 30, "Test4.2 next")

	-- Test 5: Cursor safety when the item under the cursor is removed.
	-- After remove("A"), swap-pop relocates C into slot 1 and the cursor
	-- steps back, so get_current is empty and the next get_next_loop
	-- yields the relocated tail item (it takes the removed item's turn).
	dllist.get_head(list)
	dllist.remove(list, "A")
	assert(dllist.length(list) == 1, "Test5 count after removal")
	assert(dllist.find(list, "A") == nil, "Test5 find removed")

	local c5v, c5id = dllist.get_current(list)
	assert(c5v == nil and c5id == nil, "Test5 current is empty after removal")
	local n5v, n5id = dllist.get_next_loop(list)
	assert_item(n5v, n5id, 30, "Test5 next takes the removed item's turn")

	-- Test 6: Edge cases
	dllist.remove(list, "C")
	assert(dllist.length(list) == 0, "Test6 count after removal")

	assert(dllist.find(list, "C") == nil, "Test6 find on empty")
	assert(dllist.get_head(list) == nil, "Test6 head")
	assert(dllist.get_tail(list) == nil, "Test6 tail")
	assert(dllist.remove(list, "X") == false, "Test6 remove")
	assert(dllist.length(list) == 0, "Test6 count after failed remove")

	-- Test 7: ID conflict
	assert(dllist.add(list, item("A", 100)) == true, "Test7 first add")
	assert(dllist.length(list) == 1, "Test7 count after first add")
	assert(find_v(list, "A") == 100, "Test7 find after add")
	assert(dllist.add(list, item("A", 200)) == false, "Test7 conflict")
	assert(dllist.length(list) == 1, "Test7 count unchanged after conflict")

	-- Test 8: Multiple sequential operations
	dllist.add(list, item("B", 200))
	dllist.add(list, item("C", 300))
	assert(dllist.length(list) == 3, "Test8 count after adds")

	assert(find_v(list, "A") == 100, "Test8 find A")
	assert(find_v(list, "B") == 200, "Test8 find B")
	assert(find_v(list, "C") == 300, "Test8 find C")

	dllist.remove(list, "A")
	dllist.remove(list, "C")
	assert(dllist.length(list) == 1, "Test8 count after removals")

	assert(dllist.find(list, "A") == nil, "Test8 find removed A")
	assert(dllist.find(list, "C") == nil, "Test8 find removed C")
	assert(find_v(list, "B") == 200, "Test8 find remaining B")

	dllist.add(list, item("D", 400))
	assert(dllist.length(list) == 2, "Test8 count after new add")
	assert(find_v(list, "D") == 400, "Test8 find new item")

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

	local v, id = dllist.get_next_loop(list)
	assert(v == nil and id == nil, "Test11.1 empty list")

	dllist.add(list, item("A", 10))
	dllist.get_head(list)

	local v11, id11 = dllist.get_next_loop(list)
	assert_item(v11, id11, 10, "Test11.2 single item loop")

	dllist.add(list, item("B", 20))
	dllist.add(list, item("C", 30))

	dllist.get_head(list)

	local v12, id12 = dllist.get_next_loop(list)
	assert_item(v12, id12, 20, "Test11.3 first next")

	local v13, id13 = dllist.get_next_loop(list)
	assert_item(v13, id13, 30, "Test11.4 second next")

	local v14, id14 = dllist.get_next_loop(list)
	assert_item(v14, id14, 10, "Test11.5 wrap to head")

	local v15, id15 = dllist.get_next_loop(list)
	assert_item(v15, id15, 20, "Test11.6 after wrap")

	dllist.get_tail(list)
	local v16, id16 = dllist.get_next_loop(list)
	assert_item(v16, id16, 10, "Test11.7 from tail")

	-- After removal the round-robin still covers every item
	dllist.remove(list, "B")
	dllist.get_head(list)
	dllist.get_next_loop(list)
	local v17, id17 = dllist.get_next_loop(list)
	assert_item(v17, id17, 10, "Test11.8 after removal")

	dllist.remove(list, "A")
	dllist.get_head(list)
	local v18, id18 = dllist.get_next_loop(list)
	assert_item(v18, id18, 30, "Test11.9 single item after removal")

	print("dllist.test.lua: ALL TESTS PASSED")
end

test()
