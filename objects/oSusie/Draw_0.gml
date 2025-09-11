draw_self();
if (variable_instance_exists(id, "keys_golden") == false) keys_golden = 0;
if (variable_instance_exists(id, "keys_gray") == false) keys_gray = 0;
// Mostrar iconos si tiene llaves
var offset_x = -20; // Desplazamiento inicial para centrar las llaves encima del personaje
var pos_y = y - sprite_height/2 -5; // Posición encima del personaje

// Llave dorada
if (keys_golden > 0) {
    draw_sprite(sKeyGolden, 0, x + offset_x, pos_y);
    draw_text(x + offset_x + 24, pos_y, string(keys_golden)); // Texto a la derecha del icono
    offset_x += 44; // Desplazamiento para la siguiente llave (20 píxeles de ancho + 24 para el texto)
}

// Llave gris
if (keys_gray > 0) {
    draw_sprite(sKeyGray, 0, x + offset_x, pos_y);
    draw_text(x + offset_x + 24, pos_y, string(keys_gray)); // Texto a la derecha del icono
}