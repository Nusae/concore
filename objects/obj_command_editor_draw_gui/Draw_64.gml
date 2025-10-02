//-------------------------
// FONDO DEL EDITOR
//-------------------------
var gui_width  = 250;
var gui_height = 130;
var gui_x      = 40;
var gui_y      = 420;

draw_set_color(c_gray);
draw_rectangle(gui_x, gui_y, gui_x + gui_width, gui_y + gui_height, false);

//-------------------------
// TEXTO DE OPCIONES
//-------------------------
draw_set_color(c_black);
draw_text(gui_x + 10, gui_y + 10, "Personaje: " + char_options[selected_char] + " <1 2>");
draw_text(gui_x + 10, gui_y + 40, "Acción: "    + action_options[selected_action] + " <3 4>");
draw_text(gui_x + 10, gui_y + 70, "Target: "    + (selected_target < array_length(target_options) ? target_options[selected_target] : "") + " <5 6>");

//-------------------------
// LISTAS DE COMANDOS
//-------------------------
var right_x      = room_width - 400;
var column_width = 120;
var offset_y     = 20;
var box_height   = 150;

// Ralsei
draw_set_color(c_gray);
draw_rectangle(right_x, 30, right_x + column_width, 30 + box_height, false);
draw_set_color(c_black);
draw_text(right_x + 10, 50, "Ralsei:");
if (is_array(commands_ralsei)) {
    for (var i = 0; i < array_length(commands_ralsei); i++) {
        draw_text(right_x + 10, 50 + offset_y * (i + 1), commands_ralsei[i]);
    }
}

// Kris
draw_set_color(c_gray);
draw_rectangle(right_x + column_width, 30, right_x + 2 * column_width, 30 + box_height, false);
draw_set_color(c_black);
draw_text(right_x + column_width + 10, 50, "Kris:");
if (is_array(commands_kris)) {
    for (var i = 0; i < array_length(commands_kris); i++) {
        draw_text(right_x + column_width + 10, 50 + offset_y * (i + 1), commands_kris[i]);
    }
}

// Susie
draw_set_color(c_gray);
draw_rectangle(right_x + 2 * column_width, 30, right_x + 3 * column_width, 30 + box_height, false);
draw_set_color(c_black);
draw_text(right_x + 2 * column_width + 10, 50, "Susie:");
if (is_array(commands_susie)) {
    for (var i = 0; i < array_length(commands_susie); i++) {
        draw_text(right_x + 2 * column_width + 10, 50 + offset_y * (i + 1), commands_susie[i]);
    }
}
