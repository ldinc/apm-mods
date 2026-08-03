---@alias K any

---@class DLLItem: table
---@field id K

---@alias V DLLItem

---@class DLL : table
---@field values V[]                  -- Packed array of values; indices 1..count are live
---@field index_of table<K, integer>  -- Reverse map: id -> current array index
---@field cursor integer              -- Round-robin iteration position (0 means "before head")
---@field count integer               -- Number of live items (== #values while count > 0)

---Create a new queue.
---
---Despite the legacy class name `DLL`, the internal representation is a
---packed array with swap-pop removal. Iteration order is insertion order;
---`get_next_loop` walks the array cyclically. All public operations are
---amortised O(1) and allocate no wrapper nodes, which keeps GC pressure low
---for large queues held in `storage`.
---
---Contract: values must be tables with an `id` field. The id is the only
---identity the container tracks; there is no separate id array.
---@generic K, V
---@return DLL<K, V>
local function new()
	return {
		values   = {},
		index_of = {},
		cursor   = 0,
		count    = 0,
	}
end

---Reset the queue to an empty state.
---@generic K, V
---@param self DLL<K, V>
---@return nil
local function reset(self)
	self.values   = {}
	self.index_of = {}
	self.cursor   = 0
	self.count    = 0
end

---Add a value to the end of the queue. The value's `id` field must be unique.
---Returns false if the id is already present.
---@generic K, V
---@param self DLL<K, V>
---@param value V
---@return boolean added
local function add(self, value)
	local id = value.id

	if self.index_of[id] then
		return false
	end

	local n           = self.count + 1
	self.values[n]    = value
	self.index_of[id] = n
	self.count        = n

	return true
end

---Remove a value by id. O(1) via swap-pop with the tail.
---The round-robin cursor is fixed up so that:
---  * if the cursor was on the removed item, it steps back, so the next
---    `get_next_loop` lands on the item that moved into the freed slot
---    (the relocated tail item effectively takes the removed item's turn);
---  * if the cursor was on the tail item (which moved), it follows it.
---Returns false if the id is not in the queue.
---@generic K, V
---@param self DLL<K, V>
---@param id K
---@return boolean removed
local function remove(self, id)
	local index_of = self.index_of
	local i        = index_of[id]
	if not i then return false end

	local n      = self.count
	local values = self.values
	local cursor = self.cursor

	if i ~= n then
		-- Move the tail element into slot `i`.
		local last_value        = values[n]
		values[i]               = last_value
		index_of[last_value.id] = i

		-- Cursor fixup.
		if cursor == n then
			-- The item the cursor pointed at moved from `n` to `i`.
			self.cursor = i
		elseif cursor == i then
			-- We removed the item at the cursor. Step back so the next
			-- get_next_loop advances to `i` (the relocated tail item),
			-- which effectively takes the removed item's turn.
			self.cursor = i - 1
		end
	else
		-- Removing the tail slot itself.
		if cursor == n then
			self.cursor = n - 1
		end
	end

	values[n]    = nil
	index_of[id] = nil
	self.count   = n - 1

	return true
end

---Find a value by id. The second return value is true iff found.
---@generic K, V
---@param self DLL<K, V>
---@param id K
---@return V|nil value
---@return boolean found
local function find(self, id)
	local i = self.index_of[id]
	if i then
		return self.values[i], true
	end

	return nil, false
end

---Get the value and id at the current cursor position without moving it.
---Returns nil, nil if the cursor is not on a valid slot (empty queue or
---after a removal that left the cursor at 0).
---@generic K, V
---@param self DLL<K, V>
---@return V|nil value
---@return K|nil id
local function get_current(self)
	local c = self.cursor
	if c < 1 or c > self.count then
		return nil, nil
	end

	return self.values[c], self.values[c].id
end

---Advance the cursor and return the next value/id. Returns nil, nil at
---the end of the queue (does not wrap). Use `get_next_loop` for cyclic
---iteration.
---@generic K, V
---@param self DLL<K, V>
---@return V|nil value
---@return K|nil id
local function get_next(self)
	local c = self.cursor + 1
	if c > self.count then
		return nil, nil
	end

	self.cursor = c
	return self.values[c], self.values[c].id
end

---Advance the cursor with wrap-around. Returns nil, nil only when the
---queue is empty.
---@generic K, V
---@param self DLL<K, V>
---@return V|nil value
---@return K|nil id
local function get_next_loop(self)
	local n = self.count
	if n == 0 then
		return nil, nil
	end

	local c = self.cursor + 1
	if c > n then c = 1 end

	self.cursor = c
	return self.values[c], self.values[c].id
end

---Set the cursor to the head and return its value/id.
---@generic K, V
---@param self DLL<K, V>
---@return V|nil value
---@return K|nil id
local function get_head(self)
	if self.count == 0 then
		self.cursor = 0
		return nil, nil
	end

	self.cursor = 1
	return self.values[1], self.values[1].id
end

---Set the cursor to the tail and return its value/id.
---@generic K, V
---@param self DLL<K, V>
---@return V|nil value
---@return K|nil id
local function get_tail(self)
	local n = self.count
	if n == 0 then
		self.cursor = 0
		return nil, nil
	end

	self.cursor = n
	return self.values[n], self.values[n].id
end

---Number of items currently in the queue.
---@generic K, V
---@param self DLL<K, V>
---@return integer
local function length(self)
	return self.count
end

local dllist = {
	new           = new,
	reset         = reset,
	add           = add,
	remove        = remove,
	find          = find,
	get_current   = get_current,
	get_next      = get_next,
	get_next_loop = get_next_loop,
	get_head      = get_head,
	get_tail      = get_tail,
	length        = length,
}

return dllist
