// --- HUD de estadísticas unificado ---
draw_set_color(c_white);

// Dibujar llaves con sus respectivos sprites
if (sprite_exists(sKeyGolden)) {
    draw_sprite(sKeyGolden, 0, 20, 20);
    draw_text(40, 20, "x " + string(global.keys_golden));
}

if (sprite_exists(sKeyGray)) {
    draw_sprite(sKeyGray, 0, 20, 40);
    draw_text(40, 40, "x " + string(global.keys_gray));
}

// Dibujar estado "Sentado" (000, 111, etc)
var s_stats = string(global.sentado_kris) + string(global.sentado_susie) + string(global.sentado_ralsei);
draw_text(40, 60, "Sentado " + s_stats);

// Visual de la pantalla de fallo (común a todos los niveles)
if (global.show_fail_window) {
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(10, 100, 500, 200, false);
    draw_set_alpha(1);
    
    draw_set_color(c_white);
    draw_text(100, 130, "¡Has fallado!\nPulsa 8 para repetir");
}
