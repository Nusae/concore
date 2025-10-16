// Dibujar burbujas para personajes
if (global.msg_text != "" && instance_exists(global.msg_speaker)
    && string_pos("Todos:", dialog_text) != 1
    && string_pos("Ordenador:", dialog_text) != 1
    && string_pos("Sistema:", dialog_text) != 1
    && global.msg_speaker != self) {

    show_debug_message("Draw - Entrando en bloque Burbuja de personaje");
    show_debug_message("Draw - global.msg_speaker: " + string(global.msg_speaker));
    show_debug_message("Draw - global.msg_text: " + global.msg_text);

    // Usar fuente más pequeña para las burbujas
    draw_set_font(fnt_espanol_small); // Asegúrate de crear esta fuente en GameMaker

    // Convertir coordenadas del mundo a coordenadas de la cámara
    var px = global.msg_speaker.x + 100 - camera_get_view_x(view_camera[0]);
    var py = global.msg_speaker.y + 50 - camera_get_view_y(view_camera[0]);

    var text = global.msg_text;
    
    // Tamaño de la burbuja
    var half_width = 40;
    var half_height = 25;
    
    // Ajustar altura basada en el envoltorio de texto
    var text_width = half_width * 1.8;
    var text_height = string_height_ext(text, -1, text_width);
    if (text_height > (half_height * 2 - 10)) {
        half_height = (text_height / 2) + 15;
    }

    // Fondo
    draw_set_color(c_black);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, false);

    // Bordes blancos
    draw_set_color(c_white);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, true);

    // Texto con color según el hablante
    if (global.msg_speaker == oSusie) {
        draw_set_color(c_aqua);
    } else if (global.msg_speaker == oRalsei) {
        draw_set_color(c_lime);
    } else if (global.msg_speaker == oKris) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }

    draw_text_ext(px - half_width + 10, py - half_height + 5, text, -1, text_width);

    // Restaurar fuente original para evitar afectar otros dibujos
    draw_set_font(fnt_espanol);
}