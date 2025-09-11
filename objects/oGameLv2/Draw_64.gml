// Dibujar llave dorada y cantidad
draw_sprite(sKeyGolden, 0, 20, 20); // Sprite de la llave dorada
draw_text(40, 20, "x " + string(global.keys_golden)); // Cantidad al lado

// Dibujar llave gris y cantidad
draw_sprite(sKeyGray, 0, 20, 40); // Sprite de la llave gris
draw_text(40, 40, "x " + string(global.keys_gray)); // Cantidad al lado

//Visual de la pantalla de fallo	
if (global.show_fail_window) {
    // Fondo semi-transparente
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(10, 100, 500, 200, false);
    draw_set_alpha(1);
    
    // Texto del mensaje
    draw_set_color(c_white);
    draw_text(100, 130, "¡Has fallado!\nPulsa 8 para repetir");
}
