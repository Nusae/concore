// EVENTO DRAW GUI
draw_set_font(fnt_espanol);

// Depuración: Verificar el estado de las variables clave
show_debug_message("Draw GUI - dialog_text: " + string(dialog_text));
show_debug_message("Draw GUI - finished: " + string(finished));
show_debug_message("Draw GUI - global.msg_text: " + global.msg_text);
show_debug_message("Draw GUI - global.msg_speaker: " + string(global.msg_speaker));

// Dibujar cuadro de diálogo para Ordenador (estilo Undertale)
if (!finished && string_pos("Ordenador:", dialog_text) == 1) {
    show_debug_message("Draw GUI - Entrando en bloque Ordenador");
    draw_set_color(c_white); // Borde blanco
    
    var border_thickness = 4; 
    for (var i = 0; i < border_thickness; i++) {
        draw_rectangle(50 - i, display_get_gui_height() - 150 - i, display_get_gui_width() - 50 + i, display_get_gui_height() - 50 + i, true);
    }

    // Fondo negro
    draw_set_color(c_black);
    draw_rectangle(50, display_get_gui_height() - 150, display_get_gui_width() - 50, display_get_gui_height() - 50, false);

    // Texto en rojo para Ordenador
    draw_set_color(c_red);
    draw_text(70, display_get_gui_height() - 130, string_delete(dialog_text, 1, 10)); // Quitar "Ordenador: "
}

// Dibujar cuadro de diálogo para Sistema (texto blanco)
if (!finished && string_pos("Sistema:", dialog_text) == 1) {
    show_debug_message("Draw GUI - Entrando en bloque Sistema");
    draw_set_color(c_white); // Borde blanco

    var border_thickness = 4; 
    for (var i = 0; i < border_thickness; i++) {
        draw_rectangle(50 - i, display_get_gui_height() - 150 - i, display_get_gui_width() - 50 + i, display_get_gui_height() - 50 + i, true);
    }

    // Fondo negro
    draw_set_color(c_black);
    draw_rectangle(50, display_get_gui_height() - 150, display_get_gui_width() - 50, display_get_gui_height() - 50, false);

    // Texto en blanco para Sistema
    draw_set_color(c_white);
    draw_text(70, display_get_gui_height() - 130, string_delete(dialog_text, 1, 9)); // Quitar "Sistema: "
}

// Dibujar cuadro de diálogo para Todos (colores alternados)
if (!finished && string_pos("Todos:", dialog_text) == 1) {
    show_debug_message("Draw GUI - Entrando en bloque Todos");
    draw_set_color(c_white); // Borde blanco
    
    var border_thickness = 4;
    for (var i = 0; i < border_thickness; i++) {
        draw_rectangle(50 - i, display_get_gui_height() - 150 - i, display_get_gui_width() - 50 + i, display_get_gui_height() - 50 + i, true);
    }

    // Fondo negro
    draw_set_color(c_black);
    draw_rectangle(50, display_get_gui_height() - 150, display_get_gui_width() - 50, display_get_gui_height() - 50, false);

    // Texto con colores alternados
    var msg = string_delete(dialog_text, 1, 6); // Quitar "Todos: "
    var x_start = 70;
    var y_pos = display_get_gui_height() - 130;
    var spacing = 12; // Espacio entre letras
    var max_width = display_get_gui_width() - 100; // Margen lateral
    var current_width = 0;

    for (var i = 1; i <= string_length(msg); i++) {
        var ch = string_char_at(msg, i);
        var ch_width = string_width(ch);

        // Si la línea se pasa del límite, saltar de línea
        if (current_width + ch_width > max_width) {
            y_pos += 20;
            x_start = 70;
            current_width = 0;
        }

        // Alternar colores
        var col_index = (i - 1) mod 3;
        switch (col_index) {
            case 0: draw_set_color(c_aqua); break;   // Susie
            case 1: draw_set_color(c_yellow); break; // Kris
            case 2: draw_set_color(c_lime); break;   // Ralsei
        }

        draw_text(x_start, y_pos, ch);
        x_start += ch_width;
        current_width += ch_width;
    }
}