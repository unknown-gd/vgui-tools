local ipairs = ipairs
local function can_remove( pnl, filters )
    if IsValid( pnl ) then
        local name = pnl:GetName()
        for num, filter in ipairs( filters ) do
            if name:match( filter ) then
                return true
            end
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