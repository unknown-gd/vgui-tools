local find, format
do
	local _obj_0 = string
	find, format = _obj_0.find, _obj_0.format
end
local Add = concommand.Add
local MsgN = MsgN
local PANEL = FindMetaTable("Panel")
local Remove, GetName, __tostring = PANEL.Remove, PANEL.GetName, PANEL.__tostring
local getPanels = nil
do
	local GetHUDPanel = GetHUDPanel
	local GetWorldPanel = vgui.GetWorldPanel
	local panels, length = setmetatable({ }, {
		__mode = "v"
	}), 0
	local addPanel
	addPanel = function(self, onlyParents)
		if not onlyParents then
			local _list_0 = self:GetChildren()
			for _index_0 = 1, #_list_0 do
				local child = _list_0[_index_0]
				addPanel(child)
			end
		end
		length = length + 1
		panels[length] = self
	end
	getPanels = function(onlyParents)
		for index = 1, length do
			panels[index] = nil
		end
		length = 0
		local _list_0 = GetHUDPanel():GetChildren()
		for _index_0 = 1, #_list_0 do
			local child = _list_0[_index_0]
			addPanel(child, onlyParents)
		end
		local _list_1 = GetWorldPanel():GetChildren()
		for _index_0 = 1, #_list_1 do
			local child = _list_1[_index_0]
			addPanel(child, onlyParents)
		end
		return panels
	end
end
do
	local remove
	remove = function(cmd, patterns, onlyParents)
		local _list_0 = getPanels(onlyParents)
		for _index_0 = 1, #_list_0 do
			local panel = _list_0[_index_0]
			if not panel:IsValid() then
				goto _continue_0
			end
			local name = GetName(panel)
			for _index_1 = 1, #patterns do
				local pattern = patterns[_index_1]
				if find(name, pattern, 1, false) ~= nil then
					MsgN("[" .. cmd .. "] " .. __tostring(panel) .. " has been removed.")
					Remove(panel)
					break
				end
			end
			::_continue_0::
		end
	end
	Add("vgui_remove", function(_, cmd, args)
		return remove(cmd, args, true)
	end)
	Add("vgui_remove_all", function(_, cmd, args)
		return remove(cmd, args, false)
	end)
end
local printTree = nil
do
	local band, bor
	do
		local _obj_0 = bit
		band, bor = _obj_0.band, _obj_0.bor
	end
	printTree = function(self, level, isLast, finishedLevels)
		finishedLevels = finishedLevels or 0
		local space = ""
		if isLast then
			finishedLevels = bor(finishedLevels, 2 ^ level)
		end
		for i = 1, level - 1 do
			if band(finishedLevels, 2 ^ i) == 0 then
				space = space .. "║   "
			else
				space = space .. "    "
			end
		end
		local children = self:GetChildren()
		local count = #children
		MsgN(space .. "║")
		MsgN(space .. (isLast and "╚" or "╠") .. "══ " .. __tostring(self))
		if count == 0 then
			return
		end
		for i = 1, count do
			printTree(children[i], level + 1, i == count, finishedLevels)
		end
	end
end
Add("vgui_list", function(_, cmd, args)
	local startPos, endPos = args[1], args[2]
	local hasArgs = startPos ~= nil or endPos ~= nil
	if hasArgs then
		if startPos then
			startPos = tonumber(startPos) or 1
		else
			startPos = 1
		end
		if endPos then
			endPos = tonumber(endPos) or startPos
		else
			endPos = startPos
		end
	end
	MsgN("[" .. cmd .. "] Panels: ")
	local counter = 0
	local _list_0 = getPanels(true)
	for _index_0 = 1, #_list_0 do
		local panel = _list_0[_index_0]
		counter = counter + 1
		if hasArgs then
			if counter < startPos then
				goto _continue_0
			end
			if counter > endPos then
				break
			end
		end
		MsgN(__tostring(panel))
		if not hasArgs then
			goto _continue_0
		end
		local children = panel:GetChildren()
		local count = #children
		if count == 0 then
			return
		end
		for i = 1, count do
			printTree(children[i], 1, i == count)
		end
		::_continue_0::
	end
	return MsgN()
end)
return Add("vgui_find", function(_, cmd, args)
	local founded, length = { }, 0
	local _list_0 = getPanels(false)
	for _index_0 = 1, #_list_0 do
		local panel = _list_0[_index_0]
		local name = GetName(panel)
		for _index_1 = 1, #args do
			local pattern = args[_index_1]
			if find(name, pattern, 1, false) ~= nil then
				length = length + 1
				founded[length] = __tostring(panel)
			end
		end
	end
	if length == 0 then
		MsgN("[" .. cmd .. "] Panels not found.")
		return
	end
	MsgN("[" .. cmd .. "] Found " .. length .. " panels: ")
	for index = 1, length do
		MsgN(founded[index])
	end
end)
