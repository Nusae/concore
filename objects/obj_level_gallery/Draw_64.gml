/// @description Dibujar menú de galería
draw_set_color(c_black);
draw_set_alpha(0.8);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(display_get_gui_width() / 2, 50, "--- GALERIA DE NIVELES ---");

if (array_length(levels) == 0) {
    draw_text(display_get_gui_width() / 2, display_get_gui_height() / 2, "No hay niveles guardados.");
} else {
    for (var i = 0; i < array_length(levels); i++) {
        var _y = 100 + (i * 30);
        var _text = levels[i];
        if (i == selected_index) {
            draw_set_color(c_yellow);
            _text = "> " + _text + " <";
        } else {
            draw_set_color(c_white);
        }
        draw_text(display_get_gui_width() / 2, _y, _text);
    }
}

draw_set_halign(fa_left);
draw_set_color(c_gray);
draw_text(20, display_get_gui_height() - 60, "ENTER: Cargar | ESC: Cerrar | DEL: Borrar");
draw_text(20, display_get_gui_height() - 40, "Controles del Editor activados al cerrar.");
