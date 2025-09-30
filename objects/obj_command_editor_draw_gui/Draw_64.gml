//--------------
// CONFIGURACIÓN INICIAL DEL EDITOR
//-------------------------
var gui_width = 250;  // Tamaño ajustado
var gui_height = 130; // Tamaño ajustado
var gui_x = 40;       // Posición fija a la izquierda
var gui_y = 420;      // Posición fija según tu modificación

//--------------
// FONDO DEL EDITOR
//-------------------------
draw_set_color(c_gray);
draw_rectangle(gui_x, gui_y, gui_x + gui_width, gui_y + gui_height, false);

//--------------
// OPCIONES DE LOS DROPDOWNS
//-------------------------
var char_options = ["Ralsei", "Kris", "Susie"];
var action_options = ["move_to", "delay"];
var target_options = selected_action == 1 ? ["1s", "2s", "5s", "1s", "2s", "5s", "1s", "2s", "5s", "1s", "2s"] : ["Wall", "Button", "Switch", "Ralsei", "Kris", "Susie", "Meta", "GoldS", "GrayS", "GoldD", "GrayD"];

//--------------
// RESET DE TARGET AL CAMBIAR ACCIÓN
//-------------------------
var prev_action = variable_instance_exists(id, "prev_action") ? prev_action : selected_action;
if (prev_action != selected_action) {
    selected_target = 0; // Reset target cuando cambia la acción
    prev_action = selected_action;
}

//--------------
// CONTROLES POR TECLAS
//-------------------------
if (keyboard_check_pressed(ord("1"))) selected_char = (selected_char - 1 + array_length(char_options)) % array_length(char_options);
if (keyboard_check_pressed(ord("2"))) selected_char = (selected_char + 1) % array_length(char_options);
if (keyboard_check_pressed(ord("3"))) selected_action = (selected_action - 1 + array_length(action_options)) % array_length(action_options);
if (keyboard_check_pressed(ord("4"))) selected_action = (selected_action + 1) % array_length(action_options);
if (keyboard_check_pressed(ord("5"))) selected_target = (selected_target - 1 + array_length(target_options)) % array_length(target_options);
if (keyboard_check_pressed(ord("6"))) selected_target = (selected_target + 1) % array_length(target_options);

//--------------
// DIBUJAR ETIQUETAS Y VALORES SELECCIONADOS
//-------------------------
draw_set_color(c_black);
draw_text(gui_x + 10, gui_y + 10, "Personaje: " + char_options[selected_char] + " <1 2>");
draw_text(gui_x + 10, gui_y + 40, "Acción: " + action_options[selected_action] + " <3 4>");
draw_text(gui_x + 10, gui_y + 70, "Target: " + (selected_target < array_length(target_options) ? target_options[selected_target] : "") + " <5 6>");

//--------------
// AÑADIR COMANDO CON ENTER
//-------------------------
if (keyboard_check_pressed(vk_enter)) {
    var command = char_options[selected_char] + " " + action_options[selected_action] + " " + target_options[selected_target];
    show_debug_message("Command typed: " + command);

    // Inicializar arrays si no existen
    if (!variable_instance_exists(id, "commands_ralsei")) commands_ralsei = [];
    if (!variable_instance_exists(id, "commands_kris")) commands_kris = [];
    if (!variable_instance_exists(id, "commands_susie")) commands_susie = [];

    switch (selected_char) {
        case 0: array_push(commands_ralsei, action_options[selected_action] + " " + target_options[selected_target]); break;
        case 1: array_push(commands_kris, action_options[selected_action] + " " + target_options[selected_target]); break;
        case 2: array_push(commands_susie, action_options[selected_action] + " " + target_options[selected_target]); break;
    }

    show_debug_message("Command added to list for " + char_options[selected_char]);
}

//--------------
// DIBUJAR LISTAS DE COMANDOS (CAJAS A LA DERECHA)
//-------------------------
var right_x = room_width - 400;
var column_width = 120;
var offset_y = 20;
var box_height = 150;

// Lista Ralsei
draw_set_color(c_gray);
draw_rectangle(right_x, 30, right_x + column_width, 30 + box_height, false);
draw_set_color(c_black);
draw_text(right_x + 10, 50, "Ralsei:");
if (variable_instance_exists(id, "commands_ralsei")) {
    for (var i = 0; i < array_length(commands_ralsei); i++) {
        draw_text(right_x + 10, 50 + offset_y * (i + 1), commands_ralsei[i]);
    }
}

// Lista Kris
draw_set_color(c_gray);
draw_rectangle(right_x + column_width, 30, right_x + 2 * column_width, 30 + box_height, false);
draw_set_color(c_black);
draw_text(right_x + column_width + 10, 50, "Kris:");
if (variable_instance_exists(id, "commands_kris")) {
    for (var i = 0; i < array_length(commands_kris); i++) {
        draw_text(right_x + column_width + 10, 50 + offset_y * (i + 1), commands_kris[i]);
    }
}

// Lista Susie
draw_set_color(c_gray);
draw_rectangle(right_x + 2 * column_width, 30, right_x + 3 * column_width, 30 + box_height, false);
draw_set_color(c_black);
draw_text(right_x + 2 * column_width + 10, 50, "Susie:");
if (variable_instance_exists(id, "commands_susie")) {
    for (var i = 0; i < array_length(commands_susie); i++) {
        draw_text(right_x + 2 * column_width + 10, 50 + offset_y * (i + 1), commands_susie[i]);
    }
}

//--------------
// DIBUJAR CAJA DE TIEMPOS
//-------------------------
var times_box_y = 30 + box_height + 20; // 20 píxeles debajo de las cajas de comandos
var times_box_height = 120; // Aumentado para evitar que el texto se corte
draw_set_color(c_gray);
draw_rectangle(right_x, times_box_y, right_x + 3 * column_width, times_box_y + times_box_height, false);

// Establecer color negro
draw_set_color(c_black);

// Establecer fuente en negrita para "TIEMPOS:"
if (asset_get_index("fnt_bold") != -1) {
    draw_set_font(asset_get_index("fnt_bold"));
} else {
    draw_set_font(-1); // Fallback a fuente predeterminada
    show_debug_message("Warning: fnt_bold not found, using default font.");
}

// Dibujar "TIEMPOS:" en negrita
draw_text(right_x + 10, times_box_y + 10, "TIEMPOS:");

// Establecer fuente normal para los valores
if (asset_get_index("fnt_espanol") != -1) {
    draw_set_font(asset_get_index("fnt_espanol"));
} else {
    draw_set_font(-1); // Fallback a fuente predeterminada
    show_debug_message("Warning: fnt_espanol not found, using default font.");
}

// Dibujar valores de tiempo
draw_text(right_x + 10, times_box_y + 30, "BOTON: 2");
draw_text(right_x + 10, times_box_y + 50, "PUERTA: 3");
draw_text(right_x + 10, times_box_y + 70, "SAVER: 2");
draw_text(right_x + 10, times_box_y + 90, "SWITCH: 1");

// Restablecer color
draw_set_color(c_white);

//--------------
// CONTROL DE MODO COMANDO CON ALT
//-------------------------
if (keyboard_check_pressed(vk_alt)) {
    global.commandmode = !global.commandmode;

    if (global.commandmode) {
        show_debug_message("Command mode activated with Alt");

        // Ejecutar todos los comandos guardados
        if (variable_instance_exists(id, "commands_ralsei")) {
            for (var i = 0; i < array_length(commands_ralsei); i++) {
                parse_command("Ralsei " + commands_ralsei[i]);
            }
        }
        if (variable_instance_exists(id, "commands_kris")) {
            for (var i = 0; i < array_length(commands_kris); i++) {
                parse_command("Kris " + commands_kris[i]);
            }
        }
        if (variable_instance_exists(id, "commands_susie")) {
            for (var i = 0; i < array_length(commands_susie); i++) {
                parse_command("Susie " + commands_susie[i]);
            }
        }
    } else {
        show_debug_message("Command mode deactivated with Alt");
        if (instance_exists(oPlayButton)) oPlayButton.playmode = false;
    }
}

//--------------
// ELIMINAR ÚLTIMO COMANDO CON CTRL+Z
//-------------------------
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("Z"))) {
    switch (selected_char) {
        case 0:
            if (variable_instance_exists(id, "commands_ralsei") && array_length(commands_ralsei) > 0) {
                array_delete(commands_ralsei, array_length(commands_ralsei)-1, 1);
                show_debug_message("Último comando de Ralsei eliminado");
            }
            break;
        case 1:
            if (variable_instance_exists(id, "commands_kris") && array_length(commands_kris) > 0) {
                array_delete(commands_kris, array_length(commands_kris)-1, 1);
                show_debug_message("Último comando de Kris eliminado");
            }
            break;
        case 2:
            if (variable_instance_exists(id, "commands_susie") && array_length(commands_susie) > 0) {
                array_delete(commands_susie, array_length(commands_susie)-1, 1);
                show_debug_message("Último comando de Susie eliminado");
            }
            break;
    }
}