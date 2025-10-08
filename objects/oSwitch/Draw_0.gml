draw_self(); 
var texto = (completed) ? "Listo" : "Falta";
var offset_x = sprite_width / 2 + 10; // Ajusta según el ancho del sprite del botón
var offset_y = -sprite_height / 2; // Ajusta para que el texto esté centrado verticalmente
draw_set_color(c_white);
draw_set_font(fnt_espanol);
draw_text_transformed(x + offset_x, y + offset_y, texto, 0.6, 0.6, 0);