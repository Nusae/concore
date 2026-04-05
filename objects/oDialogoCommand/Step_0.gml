event_inherited();

var current_room = room_get_name(room);

// 1. DEFINIR DIÁLOGOS POR SALA
if (array_length(dialogos) == 0 && !finished) {
    switch (current_room) {
        case "Lv5":
            if (!variable_global_exists("sala5_dialogue_completed") || !global.sala5_dialogue_completed) {
                dialogos = [
                    "Ordenador: JAJAJAJA te has quedado sin la habilidad de moverte libremente",
                    "Ordenador: Has de indicar con quién deseas moverte usando 1 y 2",
                    "Ordenador: Hay 4 tipos de comandos\nDelay, move_to de entrenamiento fácil.\nAhora sin confundir P y V.",
                    "Susie: P hace que tú puedas recoger la llave global para ti\nLa puerta",
                    "Susie: V devuelves la llave a general para que otros lo puedan usar.\nEl guardador de llaves",
                    "Ordenador: Ya se ve que estás entendiendo el mundo que te rodea.",
                    "Susie: Concurrencia con el uso de sistema de Dijkstra"
                ];
            } else { finished = true; }
            break;
        case "Lv6":
            if (!variable_global_exists("sala6_dialogue_completed") || !global.sala6_dialogue_completed) {
                dialogos = [
                    "Ordenador: HAHAHAHA! Siempre pasas las cosas súper rápido!",
                    "Ordenador: Debes de quedarte a hacer las cosas bien.",
                    "Ordenador: ¡Usa el delay!"
                ];
            } else { finished = true; }
            break;
    }
}

// 2. TRIGGERS DE FINALIZACIÓN
if (finished) {
    if (current_room == "Lv4") {
        room_goto(Lv5); 
    } else if (current_room == "Lv5") {
        global.sala5_dialogue_completed = true;
    } else if (current_room == "Lv6") {
        global.sala6_dialogue_completed = true;
    }
}

// 3. ESPECIAL: Start Room (si se usa oDialogoCommand allí)
if (current_room == "Start") {
    switch (dialog_index) {
        case 1: show_ralsei = true; break;
        case 2: show_susie = true; break;
        case 3: show_kris = true; break;
    }
    if (instance_exists(oRalsei)) oRalsei.visible = show_ralsei;
    if (instance_exists(oSusie)) oSusie.visible = show_susie;
    if (instance_exists(oKris)) oKris.visible = show_kris;
    
    if (finished && global.susie_cama && global.ralsei_cama && global.kris_cama) {
        room_goto(Logic);
    }
}