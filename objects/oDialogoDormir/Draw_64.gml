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
if (!finished) {
    // Detectar quién habla
    var speaker = "";
    if (string_pos("Kris:", dialog_full) == 1) speaker = "Kris";
    else if (string_pos("Susie:", dialog_full) == 1) speaker = "Susie";
    else if (string_pos("Ralsei:", dialog_full) == 1) speaker = "Ralsei";

    // Dibuja la burbuja sobre el personaje que habla
    if (speaker != "") {
        var px = 0;
        var py = 0;

        switch (speaker) {
            case "Kris":
                px = oKris.x + 130;
                py = oKris.y + 250;
                break;
            case "Susie":
                px = oSusie.x + 130;
                py = oSusie.y;
                break;
            case "Ralsei":
                px = oRalsei.x + 130;
                py = oRalsei.y;
                break;
        }

        // Parámetros de tamaño
        var half_width = 140;
        var half_height = 40;

        // Fondo de la burbuja
        draw_set_color(c_black);
        draw_roundrect(px - half_width, py - half_height, px + half_width, py, false);

        // Bordes blancos
        draw_set_color(c_white);
        draw_roundrect(px - half_width, py - half_height, px + half_width, py, true);

        // Texto del diálogo (sin el "Nombre:")
        var text_clean = string_replace(dialog_text, string_concat(speaker, ":"), "");

        // Color según el hablante
        if (speaker == "Susie") {
            draw_set_color(c_aqua); // Cian para Susie (informática)
        } else if (speaker == "Ralsei") {
            draw_set_color(c_lime); // Verde lima para Ralsei (terapeuta)
        } else if (speaker == "Kris") {
            draw_set_color(c_yellow); // Amarillo para Kris (luchadora)
        }

        // Ajustar posición del texto para estar bien dentro de la burbuja
        draw_text(px - half_width + 15, py - half_height + 10, text_clean);
    }
}
