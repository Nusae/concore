draw_self(); // Dibuja el sprite

var nombre_sala = room_get_name(room);

if (nombre_sala == "Logic") {
    nombre_sala = "Sala de Operaciones";
}

// Cambiar color a negro
draw_set_color(c_black);

draw_text(x, y, nombre_sala);

// Volver el color a blanco
draw_set_color(c_white);