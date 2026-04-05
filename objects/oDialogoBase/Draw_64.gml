//--------------
// DIBUJO BASE DE DIÁLOGO UNIFICADO
//-------------------------
draw_set_font(fnt_espanol);
if (finished || dialog_text == "") exit;

var current_dialog = dialogos[dialog_index];
var speaker = "";
var prefix = "";
var use_bubble = false;

// Determinar el modo de dibujo basado en el prefijo
if (string_pos("Kris:", current_dialog) == 1) { speaker = "Kris"; prefix = "Kris: "; use_bubble = true; }
else if (string_pos("Susie:", current_dialog) == 1) { speaker = "Susie"; prefix = "Susie: "; use_bubble = true; }
else if (string_pos("Ralsei:", current_dialog) == 1) { speaker = "Ralsei"; prefix = "Ralsei: "; use_bubble = true; }
else if (string_pos("Todos:", current_dialog) == 1) { speaker = "Todos"; prefix = "Todos: "; use_bubble = false; }
else if (string_pos("Ordenador:", current_dialog) == 1) { speaker = "Ordenador"; prefix = "Ordenador: "; use_bubble = false; }
else if (string_pos("Sistema:", current_dialog) == 1) { speaker = "Sistema"; prefix = "Sistema: "; use_bubble = false; }

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Texto real que se está escribiendo (sin el prefijo)
var text_after_prefix = string_replace(dialog_text, prefix, "");

// 1. MODO CUADRO (Ordenador, Sistema, Todos, o sin prefijo)
if (!use_bubble) {
    var border_thickness = 4;
    draw_set_color(c_white);
    for (var i = 0; i < border_thickness; i++) {
        draw_rectangle(50 - i, gui_h - 150 - i, gui_w - 50 + i, gui_h - 50 + i, true);
    }
    draw_set_color(c_black);
    draw_rectangle(50, gui_h - 150, gui_w - 50, gui_h - 50, false);

    // Ajustes de color de texto según el prefijo
    if (speaker == "Ordenador") {
        draw_set_color(c_red);
        draw_text(70, gui_h - 130, text_after_prefix);
    }
    else if (speaker == "Sistema") {
        draw_set_color(c_white);
        draw_text(70, gui_h - 130, text_after_prefix);
    }
    else if (speaker == "Todos") {
        // Efecto Arcoíris
        var msg = text_after_prefix;
        var x_start = 70;
        var y_pos = gui_h - 130;
        for (var i = 1; i <= string_length(msg); i++) {
            var ch = string_char_at(msg, i);
            var col_index = (i - 1) mod 3;
            switch (col_index) {
                case 0: draw_set_color(c_aqua); break;
                case 1: draw_set_color(c_yellow); break;
                case 2: draw_set_color(c_lime); break;
            }
            draw_text(x_start, y_pos, ch);
            x_start += string_width(ch);
        }
    }
    else {
        draw_set_color(c_white);
        draw_text(70, gui_h - 130, text_after_prefix);
    }
} 
// 2. MODO BURBUJA (Kris, Susie, Ralsei)
else {
    var target_obj = noone;
    if (speaker == "Kris") target_obj = oKris;
    else if (speaker == "Susie") target_obj = oSusie;
    else if (speaker == "Ralsei") target_obj = oRalsei;

    if (instance_exists(target_obj)) {
        var cam = view_camera[0];
        var px = target_obj.x - camera_get_view_x(cam) + 150;
        var py = target_obj.y - camera_get_view_y(cam);
        
        // Ajuste especial para Kris (estilo Undertale)
        if (speaker == "Kris") py += 150; 

        var half_width = 100; // Un poco más estrecha la burbuja
        var text_width = half_width * 1.8;
        var text_height = string_height_ext(text_after_prefix, -1, text_width);
        var half_height = (text_height / 2) + 15;

        // Dibujar burbuja
        draw_set_color(c_black);
        draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, false);
        draw_set_color(c_white);
        draw_roundrect(px - half_width, py - half_height, px + half_width, py + half_height, true);

        // Color del texto según personaje
        if (speaker == "Susie") draw_set_color(c_aqua);
        else if (speaker == "Ralsei") draw_set_color(c_lime);
        else if (speaker == "Kris") draw_set_color(c_yellow);
        
        draw_text_ext(px - half_width + 10, py - half_height + 5, text_after_prefix, -1, text_width);
    }
}
