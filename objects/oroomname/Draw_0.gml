draw_self(); // Dibuja el sprite

var nombre_sala = room_get_name(room);

if (nombre_sala == "Logic"|| nombre_sala == "Lv4") {
    nombre_sala = "Sala de Operaciones";
}else if (nombre_sala == "Start" || nombre_sala == "Sleep") {
    nombre_sala = "Dormitorio";
}else if (nombre_sala == "Lv2") {
    nombre_sala = "Lv1";
}else if (nombre_sala == "Lv3") {
    nombre_sala = "Lv2";
}else if (nombre_sala == "Lv1") {
    nombre_sala = "Lv3";
}

// Cambiar color a negro
draw_set_color(c_black);

draw_text(x+20, y+10, nombre_sala);

// Volver el color a blanco
draw_set_color(c_white);