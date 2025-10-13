// DRAW GUI EVENT
//--------------
// DIBUJAR CAJA DE TIEMPOS
//-------------------------
if (global.tempmode) {
    var right_x = room_width - 400;
    var column_width = 120;
    var box_height = 150;
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
    draw_text(right_x + 10, times_box_y + 30, "BOTON: 1");
    draw_text(right_x + 10, times_box_y + 50, "PUERTA: 3");
    draw_text(right_x + 10, times_box_y + 70, "SAVER: 2");
    draw_text(right_x + 10, times_box_y + 90, "SWITCH: 2");

    // Restablecer color
    draw_set_color(c_white);
}