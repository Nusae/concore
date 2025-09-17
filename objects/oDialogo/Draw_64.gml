
if (!finished) {
    if (show_ralsei) oRalsei.visible = true; 
    if (show_susie)  oSusie.visible = true; 
    if (show_kris)   oKris.visible = true; 
    // Fondo del cuadro de texto con borde blanco
    draw_set_color(c_white);
    draw_rectangle(50, display_get_gui_height() - 150, display_get_gui_width() - 50, display_get_gui_height() - 50, true); // Borde blanco
    draw_set_color(c_black);
    draw_rectangle(50, display_get_gui_height() - 150, display_get_gui_width() - 50, display_get_gui_height() - 50, false); // Fondo negro

    // Texto
    draw_set_color(c_white);
    draw_text(70, display_get_gui_height() - 130, dialog_text);
}