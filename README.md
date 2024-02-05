# VGUI Tools
A small pack of console commands for vgui development in Garry's Mod.

## Where is Lua code?
Written in [Yuescript](https://github.com/pigpigyyy/Yuescript), compiled Lua code can be found in [releases](https://github.com/PrikolMen/vgui-cleanup/releases) and [lua branch](https://github.com/PrikolMen/vgui-tools/tree/lua), or you can compile it yourself using compiled [Yuescript Compiler](https://github.com/pigpigyyy/Yuescript/releases/latest).

### Commands
- `vgui_remove <pattern>` - allow you remove `vgui` panels using [`patterns`](https://wiki.facepunch.com/gmod/Patterns)
- `vgui_remove_all <pattern>` - same as `vgui_remove`, but for all panels including children.
- `vgui_list <start pos/end pos> <start pos/end pos>` - outputs the list of all valid panels to the console, you can specify the length of the output list or the start and end points in the list.
- `vgui_find <pattern>` - display the list of found panels using [`patterns`](https://wiki.facepunch.com/gmod/Patterns)

### Examples

#### `vgui_list` usage
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/5d9143d5-c818-427c-9127-a72a7c90c4e9)
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/705c6414-86af-400b-8b32-348d110672ce)
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/4c695020-2fa0-4d68-bbd5-4a1558bc1013)

#### `vgui_find` usage
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/18ceb8e3-158f-4802-aad5-7299f65f6de1)
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/15e4e849-2fe2-4a1a-a1a4-9c427abd0514)

#### `vgui_remove` usage
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/ad7b5cb0-89e6-454b-b998-dc61cad890f1)
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/29c8a4d9-2678-48d9-9c2d-2790074c533c)

#### `vgui_remove_all` usage
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/270cdbec-2f7c-47ee-ba1f-d744bf50ee72)
![image](https://github.com/PrikolMen/vgui-tools/assets/44779902/36dcaace-bc71-4d19-a7b5-dbed2ef75084)
