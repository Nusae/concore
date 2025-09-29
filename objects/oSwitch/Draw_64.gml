
// Dibujar el texto al lado del botón
var texto = (completed) ? "Hecho" : "No hecho";
var offset_x = 40; // Ajusta la distancia horizontal del texto
var offset_y = 0;  // Ajusta la altura del texto
draw_set_color(c_white);
draw_set_font(fnt_espanol); // Usa tu font si quieres
draw_text(x + offset_x, y + offset_y, texto);

// Opcional: dibujar un rectángulo de fondo
draw_set_color(c_black);
draw_rectangle(x + offset_x - 4, y + offset_y - 4, x + offset_x + 40, y + offset_y + 16, false);
draw_set_color(c_white);
draw_text(x + offset_x, y + offset_y, texto);
