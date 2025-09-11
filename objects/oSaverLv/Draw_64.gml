// Dibujar llave dorada y cantidad
draw_sprite(sKeyGolden, 0, 20, 20); // Sprite de la llave dorada
draw_text(40, 20, "x " + string(global.keys_golden)); // Cantidad al lado

// Dibujar llave gris y cantidad
draw_sprite(sKeyGray, 0, 20, 40); // Sprite de la llave gris
draw_text(40, 40, "x " + string(global.keys_gray)); // Cantidad al lado
