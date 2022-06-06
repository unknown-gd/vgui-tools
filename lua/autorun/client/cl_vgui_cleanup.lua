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

    concommand.Add("vgui_list", function( ply, cmd, args )
        local start_num = (args[1] and args[2]) and args[1] or 0
        local end_num = args[2] or args[1]
        local check = args[1] ~= nil or args[2] ~= nil

        if (check) then
            if (start_num) then
                start_num = tonumber( start_num )
            end

            if (end_num) then
                end_num = tonumber( end_num )
            end
        end

        local num = 0
        for key, value in pairs( debug_getregistry() ) do
            if ispanel( value ) then
                num = num + 1

                if (check) then
                    if (num < start_num) then continue end
                    if (num > end_num) then break end
                end

                MsgC( "[", cmd, "] ", num, ". ", ColorRand(), value:GetName(), " (", value:GetClassName(), ")\n" )
            end
        end
    end)

end
