local whitelist = {
	["atlaschat.chat.list"] = true,
	["CGMODMouseInput"] = true,
	["atlaschat.chat"] = true,
	["ControlPanel"] = true,
	["ContextMenu"] = true,
	["xlib_Panel"] = true,
	["SpawnMenu"] = true,
	["DMenuBar"] = true,
	["DMenu"] = true,
	["Panel"] = true
}

local blacklist = {
    ["scoreboard"] = true,
    ["gcompute"] = true,
    ["playx"] = true,
    ["menu"] = true,
    ["f1"] = true,
    ["f2"] = true,
    ["f3"] = true,
    ["f4"] = true
}

local ipairs = ipairs
local function can_remove( pnl, filters )
    if IsValid( pnl ) then

        local name = pnl:GetName()
        if (#filters > 0) then
            for num, filter in ipairs( filters ) do
                if name:match( filter ) then
                    return true
                end
            end
        else
            if blacklist[ name ] then return false end
            if whitelist[ name ] then return true end
            if whitelist[ pnl:GetClassName() ] then return true end
        end

        return false
    end

    return true
end

do

    local debug_getregistry = debug.getregistry
    local ispanel = ispanel
    local pairs = pairs

    concommand.Add("vgui_cleanup", function( ply, cmd, args )
        for num, pnl in pairs( debug_getregistry() ) do
            if ispanel( pnl ) and can_remove( pnl, args ) then
                MsgC( "[", cmd, "] Removed: ", ColorRand(), pnl:GetName(), " (", pnl:GetClassName(), ")\n" )
                pnl:Remove()
                pnl = nil
            end
        end
    end)

end