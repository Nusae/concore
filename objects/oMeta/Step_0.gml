// if everyone in meta then script to change room 
// Kris
if (place_meeting(x, y, oKris)) {
    global.kris_meta = true;
}

// Ralsei
if (place_meeting(x, y, oRalsei)) {
    global.ralsei_meta = true;
}

// Susie
if (place_meeting(x, y, oSusie)) {
    global.susie_meta = true;
}


if (global.kris_meta && global.ralsei_meta && global.susie_meta) {
    show_debug_message("¡Todos llegaron a la meta! Cambiando de nivel...");
    
    // Reiniciar flags para el próximo nivel
    global.kris_meta = false;
    global.ralsei_meta = false;
    global.susie_meta = false;

    // Cambiar de sala según la actual
    switch (room) {
        case Lv1: room_goto(Lv2); break;
        case Lv2: room_goto(Lv3); break;
        case Lv3: room_goto(Lv4); break;
        case Lv4: show_debug_message("¡Has completado todos los niveles!"); break;
    }
}

