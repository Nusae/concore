/// @description Handle Alt for simulation start
if (keyboard_check_pressed(vk_alt)) {
    // Toggle global.commandmode
    global.commandmode = !global.commandmode;
    if (global.commandmode) {
        show_debug_message("Command mode activated with Alt");
        if (!variable_global_exists("char_commands")) {
            global.char_commands = ds_map_create();
            show_debug_message("char_commands initialized");
        }
    } else {
        show_debug_message("Command mode deactivated with Alt");
        // Detener movimientos si es necesario
        if (instance_exists(oPlayButton)) oPlayButton.playmode = false;
    }
}