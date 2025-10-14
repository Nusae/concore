draw_set_font(fnt_espanol);

if (global.msg_text != "" && instance_exists(global.msg_speaker)) {
    var px = global.msg_speaker.x+ 100;
    var py = global.msg_speaker.y + 50; // posición sobre la cabeza (ajústalo si hace falta)

    var text = global.msg_text;

    // 🔲 Tamaño de la burbuja
    var half_width = 80;
    var half_height = 25;

    // Fondo
    draw_set_color(c_black);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + 10, false);

    // Bordes blancos
    draw_set_color(c_white);
    draw_roundrect(px - half_width, py - half_height, px + half_width, py + 10, true);

    // Texto
    draw_text(px - string_width(text)/2, py - half_height + 5, text);
}
