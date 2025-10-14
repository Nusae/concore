draw_set_font(fnt_espanol);

if (!finished) {
    // Detectar quién habla
    var speaker = "";
    if (string_pos("Kris:", dialog_full) == 1) speaker = "Kris";
    else if (string_pos("Susie:", dialog_full) == 1) speaker = "Susie";
    else if (string_pos("Ralsei:", dialog_full) == 1) speaker = "Ralsei";

    // 💬 Dibuja la burbuja sobre el personaje que habla
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

        // 🔲 Parámetros de tamaño
        var half_width = 140;  // antes era 60 → ahora el doble
        var half_height = 40;

        // Fondo de la burbuja
        draw_set_color(c_black);
        draw_roundrect(px - half_width, py - half_height, px + half_width, py, false);

        // Bordes blancos
        draw_set_color(c_white);
        draw_roundrect(px - half_width, py - half_height, px + half_width, py, true);

        // Texto del diálogo (sin el "Nombre:")
        var text_clean = string_replace(dialog_text, string_concat(speaker, ":"), "");

        // Ajustar posición del texto para estar bien dentro de la burbuja
        draw_text(px - half_width + 15, py - half_height + 10, text_clean);
    }
}
