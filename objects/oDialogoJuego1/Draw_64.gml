draw_set_font(fnt_espanol);

// Dibujar cuadro de diálogo para Ordenador (estilo Undertale)
if (!finished && string_pos("Ordenador:", dialog_text) == 1) {
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

// Dibujar cuadro de diálogo para Todos (colores alternados)
if (!finished && string_pos("Todos:", dialog_text) == 1) {
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

// Dibujar burbujas para personajes
if (global.msg_text != "" && instance_exists(global.msg_speaker)) {
    var px = global.msg_speaker.x + 100;
    var py = global.msg_speaker.y + 50; // Posición sobre la cabeza

    var text = global.msg_text;
    
    // Tamaño de la burbuja: normal para diálogos de personajes
    var half_width = 80;
    var half_height = 25;
    
    // Ajustar altura basada en el envoltorio de texto
    var text_width = half_width * 1.8; // Ancho disponible para texto
    var text_height = string_height_ext(text, -1, text_width);
    if (text_height > (half_height * 2 - 10)) {
        half_height = (text_height / 2) + 15; // Ajustar altura dinámica
    }

    // Fondo
    draw_set_color(c_black);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, false);

    // Bordes blancos
    draw_set_color(c_white);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, true);

    // Texto con color según el hablante
    if (global.msg_speaker == oSusie) {
        draw_set_color(c_aqua); // Cian para Susie (informática)
    } else if (global.msg_speaker == oRalsei) {
        draw_set_color(c_lime); // Verde lima para Ralsei (terapeuta)
    } else if (global.msg_speaker == oKris) {
        draw_set_color(c_yellow); // Amarillo para Kris (luchadora)
    } else {
        draw_set_color(c_white); // Blanco por defecto
    }

    draw_text_ext(px - half_width + 10, py - half_height + 5, text, -1, text_width);
}
