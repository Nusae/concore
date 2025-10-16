draw_set_font(fnt_espanol);

if (global.msg_text != "" && instance_exists(global.msg_speaker)) {
    var px = global.msg_speaker.x + 100;
    var py = global.msg_speaker.y + 50; // Posición sobre la cabeza

    var text = global.msg_text;

    // ───────────────────────────────
    // Cálculo automático del tamaño de la burbuja
    // ───────────────────────────────
    var base_half_width = 80;  // Tamaño base
    var max_width = 300;       // Ancho máximo permitido antes de envolver texto
    var margin = 15;           // Margen interno de la burbuja

    // Calcular el ancho del texto con envoltorio
    var text_width = string_width_ext(text, -1, max_width);
    var text_height = string_height_ext(text, -1, max_width);

    // Ajustar el tamaño de la burbuja
    var half_width = clamp(text_width / 2 + margin, base_half_width, max_width / 1.5);
    var half_height = text_height / 2 + margin;

    // ───────────────────────────────
    // Dibujo de fondo y borde
    // ───────────────────────────────
    draw_set_color(c_black);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, false);

    draw_set_color(c_white);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, true);

    // ───────────────────────────────
    // Color del texto según hablante
    // ───────────────────────────────
    if (global.msg_speaker == self) {
        draw_set_color(c_aqua); // Cian para el ordenador (análisis)
    } else if (global.msg_speaker == oSusie) {
        draw_set_color(c_aqua); // Cian para Susie (informática)
    } else if (global.msg_speaker == oRalsei) {
        draw_set_color(c_lime); // Verde lima para Ralsei (terapeuta)
    } else if (global.msg_speaker == oKris) {
        draw_set_color(c_yellow); // Amarillo para Kris (luchadora)
    } else {
        draw_set_color(c_white); // Blanco por defecto
    }

    // ───────────────────────────────
    // Dibujo del texto con envoltorio
    // ───────────────────────────────
    draw_text_ext(px - half_width + margin, py - half_height + margin, text, -1, max_width);
}