draw_set_font(fnt_espanol);

if (global.msg_text != "" && instance_exists(global.msg_speaker)) {
    var px = global.msg_speaker.x + 100;
    var py = global.msg_speaker.y + 50; // Posición sobre la cabeza

    var text = global.msg_text;
    
    // Determinar si es la frase larga (mensaje de análisis)
    var is_long_phrase = (text == "Analizando sistema: protocolos de datos intactos, sin anomalías detectadas.");
    
    // Tamaño de la burbuja: x3 si es la frase larga, normal de lo contrario
    var half_width = is_long_phrase ? 240 : 80;
    var half_height = is_long_phrase ? 75 : 25;
    
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
    if (global.msg_speaker == self) {
        draw_set_color(c_red); // Rojo para el ordenador (análisis)
    } else if (global.msg_speaker == oSusie) {
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
