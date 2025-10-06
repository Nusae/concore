//-------------------------
// OPCIONES DE LOS DROPDOWNS
//-------------------------
char_options   = ["Ralsei", "Kris", "Susie"];
action_options = ["move_to", "delay", "P", "V"];

target_options = selected_action == 1
    ? ["1s","2s","3s","1s","2s","3s","1s"]
    : (selected_action == 0
        ? ["Wall","Button","Switch","Ralsei","Kris","Susie","Meta"]
        : ["Oro","Gris","Oro","Gris","Oro","Gris","Oro"]);

//-------------------------
// RESET DE TARGET AL CAMBIAR ACCIÓN
//-------------------------
if (!variable_instance_exists(id, "prev_action")) prev_action = selected_action;
if (prev_action != selected_action) {
    selected_target = 0;
    prev_action = selected_action;
}

//-------------------------
// CONTROLES POR TECLAS
//-------------------------
if (keyboard_check_pressed(ord("1"))) selected_char   = (selected_char - 1 + array_length(char_options)) % array_length(char_options);
if (keyboard_check_pressed(ord("2"))) selected_char   = (selected_char + 1) % array_length(char_options);
if (keyboard_check_pressed(ord("3"))) selected_action = (selected_action - 1 + array_length(action_options)) % array_length(action_options);
if (keyboard_check_pressed(ord("4"))) selected_action = (selected_action + 1) % array_length(action_options);
if (keyboard_check_pressed(ord("5"))) selected_target = (selected_target - 1 + array_length(target_options)) % array_length(target_options);
if (keyboard_check_pressed(ord("6"))) selected_target = (selected_target + 1) % array_length(target_options);

//-------------------------
// AÑADIR COMANDO CON ENTER
//-------------------------
if (keyboard_check_pressed(vk_enter)) {
    var command = char_options[selected_char] + " " + action_options[selected_action] + " " + target_options[selected_target];
    show_debug_message("Command typed: " + command);

    if (!variable_instance_exists(id, "commands_ralsei")) commands_ralsei = [];
    if (!variable_instance_exists(id, "commands_kris"))   commands_kris   = [];
    if (!variable_instance_exists(id, "commands_susie"))  commands_susie  = [];

    switch (selected_char) {
        case 0: array_push(commands_ralsei, action_options[selected_action] + " " + target_options[selected_target]); break;
        case 1: array_push(commands_kris,   action_options[selected_action] + " " + target_options[selected_target]); break;
        case 2: array_push(commands_susie,  action_options[selected_action] + " " + target_options[selected_target]); break;
    }
}

//-------------------------
// CONTROL DE MODO COMANDO CON ALT
//-------------------------
if (keyboard_check_pressed(vk_alt)) {
    global.commandmode = !global.commandmode;

    if (global.commandmode) {
        show_debug_message("Command mode activated with Alt");

        // Ejecutar listas de comandos
        var _exec_list = function(_char, _array) {
            if (!is_array(_array)) exit;

            for (var i = 0; i < array_length(_array); i++) {
                var cmd     = _array[i];
                var action  = string_copy(cmd, 1, string_pos(" ", cmd) - 1);
                var target  = string_copy(cmd, string_pos(" ", cmd) + 1, string_length(cmd));
                var translated_cmd = cmd;

                // Traducción de P y V a move_to
                if (action == "P" || action == "V") {
                    if (action == "P" && target == "Oro")  translated_cmd = "move_to GoldD";
                    if (action == "P" && target == "Gris") translated_cmd = "move_to GrayD";
                    if (action == "V" && target == "Oro")  translated_cmd = "move_to GoldS";
                    if (action == "V" && target == "Gris") translated_cmd = "move_to GrayS";
                }

                parse_command(_char + " " + translated_cmd);
            }
        };

        _exec_list("Ralsei", commands_ralsei);
        _exec_list("Kris",   commands_kris);
        _exec_list("Susie",  commands_susie);

    } else {
        show_debug_message("Command mode deactivated with Alt");
        if (instance_exists(oPlayButton)) oPlayButton.playmode = false;
    }
}

//-------------------------
// ELIMINAR ÚLTIMO COMANDO CON CTRL+Z
//-------------------------
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("Z"))) {
    switch (selected_char) {
        case 0: if (is_array(commands_ralsei) && array_length(commands_ralsei) > 0) array_delete(commands_ralsei, array_length(commands_ralsei) - 1, 1); break;
        case 1: if (is_array(commands_kris)   && array_length(commands_kris)   > 0) array_delete(commands_kris,   array_length(commands_kris) - 1,   1); break;
        case 2: if (is_array(commands_susie)  && array_length(commands_susie)  > 0) array_delete(commands_susie,  array_length(commands_susie) - 1,  1); break;
    }
}
