/// @function parse_command(input_string)
/// @description Breaks down a command string (e.g., "Ralsei move_to ball") into character, action, and target, and stores it
function parse_command(input_string) {
    var words = string_split(input_string, " ");
    if (array_length(words) >= 2) {
        var character = words[0];
        var action = words[1];
        var target = (array_length(words) > 2) ? words[2] : "";
        if (!variable_global_exists("char_commands")) {
            global.char_commands = ds_map_create();
        }
        if (!ds_map_exists(global.char_commands, character)) {
            global.char_commands[? character] = ds_list_create();
        }
        var cmd = {
            action: action,
            target: target,
            time: 0
        };
        ds_list_add(global.char_commands[? character], cmd);
        show_debug_message("Parsed: " + character + " " + action + " " + target);
    }
}