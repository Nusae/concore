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

// Dibujar burbujas para personajes
if (!finished && global.msg_text != "" && instance_exists(global.msg_speaker)) {
    var px = 0;
    var py = 0;

    // Determinar posición según el hablante
    if (global.msg_speaker == oKris) {
        px = oKris.x + 130;
        py = oKris.y + 250;
    } else if (global.msg_speaker == oSusie) {
        px = oSusie.x + 130;
        py = oSusie.y;
    } else if (global.msg_speaker == oRalsei) {
        px = oRalsei.x + 130;
        py = oRalsei.y;
    }

    // Parámetros de tamaño
    var half_width = 140;
    var half_height = 40;

    // Ajustar altura basada en el envoltorio de texto
    var text_width = half_width * 1.8; // Ancho disponible para texto
    var text_height = string_height_ext(global.msg_text, -1, text_width);
    if (text_height > (half_height * 2 - 10)) {
        half_height = (text_height / 2) + 15; // Ajustar altura dinámica
    }

    // Fondo de la burbuja
    draw_set_color(c_black);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, false);

    // Bordes blancos
    draw_set_color(c_white);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, true);

    // Color según el hablante
    if (global.msg_speaker == oSusie) {
        draw_set_color(c_aqua); // Cian para Susie (informática)
    } else if (global.msg_speaker == oRalsei) {
        draw_set_color(c_lime); // Verde lima para Ralsei (terapeuta)
    } else if (global.msg_speaker == oKris) {
        draw_set_color(c_yellow); // Amarillo para Kris (luchadora)
    }

    // Dibujar texto con envoltorio
    draw_text_ext(px - half_width + 10, py - half_height + 5, global.msg_text, -1, text_width);
}