if (!finished) {
   
    draw_set_color(c_white);
    
    var border_thickness = 4; 
    for (var i = 0; i < border_thickness; i++) {
        draw_rectangle(50 - i, display_get_gui_height() - 150 - i, display_get_gui_width() - 50 + i, display_get_gui_height() - 50 + i, true);
    }

    // Fondo negro
    draw_set_color(c_black);
    draw_rectangle(50, display_get_gui_height() - 150, display_get_gui_width() - 50, display_get_gui_height() - 50, false); // Fondo negro

    // Texto
    draw_set_color(c_white);
    draw_text(70, display_get_gui_height() - 130, dialog_text);
}