// DRAW GUI EVENT
//--------------
// DIBUJAR CAJA DE TIEMPOS
//-------------------------
var right_x = room_width - 400;
var column_width = 120;
var box_height = 150;
var times_box_y = 30 + box_height + 20; // 20 píxeles debajo de las cajas de comandos
var times_box_height = 120; // Aumentado para evitar que el texto se corte

draw_set_color(c_dkgray);
draw_rectangle(right_x, times_box_y, right_x + 3 * column_width, times_box_y + times_box_height, false);

// Establecer color blanco para el texto
draw_set_color(c_white);

    // Establecer fuente en negrita para "TIEMPOS:"
    if (asset_get_index("fnt_bold") != -1) {
        draw_set_font(asset_get_index("fnt_bold"));
    } else {
        draw_set_font(-1); // Fallback a fuente predeterminada
        show_debug_message("Warning: fnt_bold not found, using default font.");
    }

    // Dibujar "TIEMPOS:" en negrita
    draw_text(right_x + 10, times_box_y + 10, "TIEMPOS:");

    // Establecer fuente normal para los valores
    if (asset_get_index("fnt_espanol") != -1) {
        draw_set_font(asset_get_index("fnt_espanol"));
    } else {
        draw_set_font(-1); // Fallback a fuente predeterminada
        show_debug_message("Warning: fnt_espanol not found, using default font.");
    }

    // Dibujar valores de tiempo dinámicos
    draw_set_halign(fa_left);
    
    // BOTones
    var btn_total = instance_number(oButton);
    var btn_done = 0;
    with (oButton) { if (completed) btn_done++; }
    var btn_text = "BOTON (1s): " + (btn_total > 0 ? (btn_done == btn_total ? "Acabado" : "Sin hacer (" + string(btn_done) + "/" + string(btn_total) + ")") : "N/A");
    draw_text(right_x + 10, times_box_y + 30, btn_text);

    // PUERtas (Gold y Gray)
    var dr_total = instance_number(oGoldD) + instance_number(oGrayD);
    var dr_done = 0;
    with (oGoldD) { if (opened) dr_done++; }
    with (oGrayD) { if (opened) dr_done++; }
    var dr_text = "PUERTA (3s): " + (dr_total > 0 ? (dr_done == dr_total ? "Acabado" : "Sin hacer (" + string(dr_done) + "/" + string(dr_total) + ")") : "N/A");
    draw_text(right_x + 10, times_box_y + 50, dr_text);

    // SAVers (Gold y Gray)
    var sv_total = instance_number(oGoldS) + instance_number(oGrayS);
    var sv_done = 0;
    with (oGoldS) { if (used) sv_done++; }
    with (oGrayS) { if (used) sv_done++; }
    var sv_text = "SAVER (2s): " + (sv_total > 0 ? (sv_done == sv_total ? "Acabado" : "Sin hacer (" + string(sv_done) + "/" + string(sv_total) + ")") : "N/A");
    draw_text(right_x + 10, times_box_y + 70, sv_text);

    // SWITCHes
    var sw_total = instance_number(oSwitch);
    var sw_done = 0;
    with (oSwitch) { if (completed) sw_done++; }
    var sw_text = "SWITCH (2s): " + (sw_total > 0 ? (sw_done == sw_total ? "Acabado" : "Sin hacer (" + string(sw_done) + "/" + string(sw_total) + ")") : "N/A");
    draw_text(right_x + 10, times_box_y + 90, sw_text);

    // Restablecer color
    draw_set_color(c_white);