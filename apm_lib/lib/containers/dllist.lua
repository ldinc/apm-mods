---@class DLLNode : table<K, V>
---@field id K
---@field value V
---@field prev DLLNode|nil
---@field next DLLNode|nil

---@class DLL : table<K, V>
---@field head DLLNode|nil
---@field tail DLLNode|nil
---@field current DLLNode|nil
---@field nodes table<K, DLLNode>
---@field count integer

---Create a new doubly linked list
---@generic K, V
---@return DLL<K, V>
local function new()
	return {
		head = nil,
		tail = nil,
		current = nil,
		nodes = {},
		count = 0 -- Initialize count
	}
end

---Reset the list to empty state
---@generic K, V
---@param self DLL<K,V>
---@return nil
local function reset(self)
	self.head = nil
	self.tail = nil
	self.current = nil
	self.nodes = {}
	self.count = 0
end

---Add a value with unique ID to the list
---@generic K, V
---@param self DLL<K,V>
---@param id K
---@param value V
---@return boolean
local function add(self, id, value)
	if self.nodes[id] then
		return false
	end

	---@type DLLNode
	local new_node = {
		id = id,
		value = value,
		prev = self.tail,
		next = nil
	}

	self.nodes[id] = new_node
	self.count = self.count + 1 -- Increment count

	if not self.head then
		self.head = new_node
		self.current = new_node
	else
		self.tail.next = new_node
	end

	self.tail = new_node
	return true
end

---Remove a value by ID
---@generic K, V
---@param self DLL<K,V>
---@param id K
---@return boolean
local function remove(self, id)
	local node = self.nodes[id]
	if not node then return false end

	if node.prev then
		node.prev.next = node.next
	else
		self.head = node.next
	end

	if node.next then
		node.next.prev = node.prev
	else
		self.tail = node.prev
	end

	if self.current == node then
		self.current = node.next or node.prev or nil
	end

	self.nodes[id] = nil
	self.count = self.count - 1 -- Decrement count

	node.next = nil
	node.prev = nil
	node.value = nil

	return true
end

---Find a value by ID
---@generic K, V
---@param self DLL<K,V>
---@param id K
---@return V|nil, boolean
local function find(self, id)
	if self.nodes[id] then
		return self.nodes[id].value, true
	end

	return nil, false
end

---Get current node's value and ID
---@generic K, V
---@param self DLL<K,V>
---@return V|nil, K|nil
local function get_current(self)
	if not self.current then return nil, nil end

	return self.current.value, self.current.id
end

---Move to and get next node (linear)
---@generic K, V
---@param self DLL<K,V>
---@return V|nil, K|nil
local function get_next(self)
	if not self.current or not self.current.next then
		return nil, nil
	end

	self.current = self.current.next

	return self.current.value, self.current.id
end

---Move to and get next node with loop behavior
---@generic K, V
---@param self DLL<K,V>
---@return V|nil, K|nil
local function get_next_loop(self)
	if not self.current then
		return nil, nil
	end

	if self.current.next then
		self.current = self.current.next
	else
		self.current = self.head -- Wrap to head when at tail
	end

	return self.current.value, self.current.id
end

---Get head node's value and ID
---@generic K, V
---@param self DLL<K,V>
---@return V|nil, K|nil
local function get_head(self)
	self.current = self.head

	if not self.head then return nil, nil end

	return self.head.value, self.head.id
end

---Get tail node's value and ID
---@generic K, V
---@param self DLL<K,V>
---@return V|nil, K|nil
local function get_tail(self)
	self.current = self.tail

	if not self.tail then return nil, nil end

	return self.tail.value, self.tail.id
end

---Get the current number of items in the list
---@generic K, V
---@param self DLL<K,V>
---@return integer
local function length(self)
	return self.count
end

local dllist = {
	new = new,
	reset = reset,
	add = add,
	remove = remove,
	find = find,
	get_current = get_current,
	get_next = get_next,
	get_next_loop = get_next_loop,
	get_head = get_head,
	get_tail = get_tail,
	length = length
}

return dllist
