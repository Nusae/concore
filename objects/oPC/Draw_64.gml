draw_set_font(fnt_espanol);

if (global.msg_text != "" && instance_exists(global.msg_speaker)) {
    var px = global.msg_speaker.x + 100;
    var py = global.msg_speaker.y + 50; // Posición sobre la cabeza (ajústalo si hace falta)

    var text = global.msg_text;
    
    // Determinar si es la frase larga (mensaje de análisis)
    var is_long_phrase = (text == "Analizando sistema: protocolos de datos intactos, sin anomalías detectadas.");
    
    // Tamaño de la burbuja: x3 si esa frase larga, normal de lo contrario
    var half_width = is_long_phrase ? 140 : 80;
    var half_height = is_long_phrase ? 35 : 25;
    
    // Ajustar altura basada en el envoltorio de texto para frases largas
    var text_width = half_width * 1.8; // Ancho disponible para texto (dejando márgenes)
    var text_height = string_height_ext(text, -1, text_width); // Calcular altura con envoltorio
    if (text_height > (half_height * 2 - 10)) {
        half_height = (text_height / 2) + 15; // Ajustar altura dinámica si es necesario
    }

    // Fondo
    draw_set_color(c_black);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, false); // Ajustado para altura dinámica

    // Bordes blancos
    draw_set_color(c_white);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, true);

    // Texto (con envoltorio para frases largas)
    draw_set_color(c_white); // Color del texto (asumiendo blanco para visibilidad)
    draw_text_ext(px - half_width + 10, py - half_height + 5, text, -1, text_width); // Envolver texto dentro del ancho
}
