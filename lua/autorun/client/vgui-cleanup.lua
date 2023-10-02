local debug_getregistry = debug.getregistry
local string_format = string.format
local string_find = string.find
local ispanel = ispanel
local pairs = pairs
local Msg = Msg
local meta = FindMetaTable("Panel")
local toString = meta.__tostring
local isValid = meta.IsValid
local getName = meta.GetName
local remove = meta.Remove
concommand.Add("vgui_cleanup", function(ply, cmd, args)
  for _, panel in pairs(debug_getregistry()) do
    local _continue_0 = false
    repeat
      if not (ispanel(panel) and isValid(panel)) then
        _continue_0 = true
        break
      end
      local name = getName(panel)
      for _index_0 = 1, #args do
        local _continue_1 = false
        repeat
          do
            local pattern = args[_index_0]
            if not (string_find(name, pattern, 1, false)) then
              _continue_1 = true
              break
            end
            Msg(string_format("[%s] %s has been removed.\n", cmd, toString(panel)))
            remove(panel)
            break
          end
          _continue_1 = true
        until true
        if not _continue_1 then
          break
        end
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end)
return concommand.Add("vgui_list", function(ply, cmd, args)
  local startPos, endPos = args[1], args[2]
  local hasArgs = startPos ~= nil or endPos ~= nil
  local counter = 0
  if hasArgs then
    if startPos then
      startPos = tonumber(startPos) or 1
    else
      startPos = 1
    end
    if endPos then
      endPos = tonumber(endPos) or startPos
    else
      startPos, endPos = 1, startPos
    end
  end
  Msg(string_format("[%s] Panel list:\n", cmd))
  for _, panel in pairs(debug_getregistry()) do
    local _continue_0 = false
    repeat
      if not (ispanel(panel) and isValid(panel)) then
        _continue_0 = true
        break
      end
      counter = counter + 1
      if hasArgs then
        if counter < startPos then
          _continue_0 = true
          break
        elseif counter > endPos then
          break
        end
      end
      Msg(string_format("%d. %s\n", counter, toString(panel)))
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end)
