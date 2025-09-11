/*draw_text(10, 10, "Enter command (): " + keyboard_string);
if (variable_global_exists("char_commands")) {
    var keys = ds_map_keys_to_array(global.char_commands);
    for (var i = 0; i < array_length(keys); i++) {
        var char = keys[i];
        var list = global.char_commands[? char];
        for (var j = 0; j < ds_list_size(list); j++) {
            var cmd = list[| j];
            draw_text(10, 30 + j * 20, char + ": " + cmd.action + " " + cmd.target);
        }
    }
}*/