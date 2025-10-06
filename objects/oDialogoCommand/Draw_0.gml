draw_set_font(fnt_espanol);

if (!finished) {

    // Determinar color de fondo según sala actual
    var current_room = room_get_name(room);
    var fondo_color;

    if (current_room == "Lv5") {
        fondo_color = make_color_rgb(173, 216, 230); 
    } else if (current_room == "Lv6") {
        fondo_color = c_red;    // Fondo rojo para Lv6
    } else {
        fondo_color = c_black;  // Color por defecto
    }

    // Borde blanco
    draw_set_color(c_white);
    var border_thickness = 4; 
    for (var i = 0; i < border_thickness; i++) {
        draw_rectangle(
            50 - i, display_get_gui_height() - 150 - i,
            display_get_gui_width() - 50 + i, display_get_gui_height() - 50 + i,
            true
        );
    }

    // Fondo dinámico (según color definido)
    draw_set_color(fondo_color);
    draw_rectangle(
        50, display_get_gui_height() - 150,
        display_get_gui_width() - 50, display_get_gui_height() - 50,
        false
    );

    // Texto blanco
    draw_set_color(c_black);
    draw_text(70, display_get_gui_height() - 130, dialog_text);
}
