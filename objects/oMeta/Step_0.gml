// Comprobar quién llegó a la meta
if (place_meeting(x, y, oKris)) {
    global.kris_meta = true;
}
if (place_meeting(x, y, oRalsei)) {
    global.ralsei_meta = true;
}
if (place_meeting(x, y, oSusie)) {
    global.susie_meta = true;
}

// --- Condición para activar la animación ---
var todos_listos = false;

if (room == Lv2) {
    // En Lv2 solo Kris y Susie deben llegar
    if (global.kris_meta && global.susie_meta) {
        todos_listos = true;
    }
} else {
    // En otros niveles, todos deben llegar
    if (global.kris_meta && global.ralsei_meta && global.susie_meta) {
        todos_listos = true;
    }
}

// --- Si todos llegaron y aún no se activó ---
if (todos_listos && !activado) {
    activado = true;
    image_speed = 0.05; // Comenzar la animación
}

// --- Si la animación está activa ---
if (activado) {
    // Si la animación llega al último frame
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;

        // Evitar múltiples ejecuciones
        if (!variable_instance_exists(id, "nivel_cambiado")) {
            nivel_cambiado = false;
        }

        if (!nivel_cambiado) {
            nivel_cambiado = true;

            // --- Cambio de nivel ---
            if (room == Lv2) {
                show_debug_message("¡Kris y Susie han llegado a la meta! Cambiando de nivel...");
                global.kris_meta = false;
                global.ralsei_meta = false;
                global.susie_meta = false;
                room_goto(Lv3);
            } else {
                show_debug_message("¡Todos llegaron a la meta! Cambiando de nivel...");
                global.kris_meta = false;
                global.ralsei_meta = false;
                global.susie_meta = false;

                switch (room) {
                    case Lv2: room_goto(Lv3); break;
                    case Lv3: room_goto(Lv1); break;
					case Lv1: room_goto(Lv4); break; 
                    case Lv4: show_debug_message("¡Has completado todos los niveles!"); break;
					case Lv5: room_goto(Lv6); break; 
                }
            }
        }
    }
}
