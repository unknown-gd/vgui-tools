debug_getregistry = debug.getregistry
string_format = string.format
string_find = string.find
ispanel = ispanel
pairs = pairs
Msg = Msg

meta = FindMetaTable( "Panel" )
toString = meta.__tostring
isValid = meta.IsValid
getName = meta.GetName
remove = meta.Remove

concommand.Add( "vgui_cleanup", ( ply, cmd, args ) ->
    for _, panel in pairs( debug_getregistry() )
        unless ispanel( panel ) and isValid( panel )
            continue

        name = getName( panel )
        for pattern in *args
            unless string_find( name, pattern, 1, false )
                continue

            Msg( string_format( "[%s] %s has been removed.\n", cmd, toString( panel ) ) )
            remove( panel )
            break
)

concommand.Add( "vgui_list", ( ply, cmd, args ) ->
    startPos, endPos = args[ 1 ], args[ 2 ]
    hasArgs = startPos ~= nil or endPos ~= nil
    counter = 0

    if hasArgs
        if startPos
            startPos = tonumber( startPos ) or 1
        else
            startPos = 1

        if endPos
            endPos = tonumber( endPos ) or startPos
        else
            startPos, endPos = 1, startPos

    Msg( string_format( "[%s] Panel list:\n", cmd ) )

    for _, panel in pairs( debug_getregistry() ) do
        unless ispanel( panel ) and isValid( panel )
            continue

        counter += 1

        if hasArgs
            if counter < startPos
                continue
            elseif counter > endPos
                break

        Msg( string_format( "%d. %s\n", counter, toString( panel ) ) )
)