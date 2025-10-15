// Inicializar variables si no existen
if (!variable_instance_exists(id, "dialog_timer")) {
    dialog_timer = 0;
    dialog_speed = 2; // Velocidad de escritura (frames por carácter)
    dialog_pos = 0;
    dialog_text = "";
    dialog_full = "";
    dialog_index = 0;
    finished = false;
    show_ralsei = false;
    show_susie = false;
    show_kris = false;
    dialogos = [];
}

// Inicializar variables globales para diálogos
if (room_get_name(room) == "Lv5" && !variable_global_exists("sala5_dialogue_completed")) {
    global.sala5_dialogue_completed = false;
}
if (room_get_name(room) == "Lv6" && !variable_global_exists("sala6_dialogue_completed")) {
    global.sala6_dialogue_completed = false;
}

// Definir diálogos por sala
var current_room = room_get_name(room);
switch (current_room) {
    case "Lv4":
        dialogos = [
            "Susie: Mira ahí está el ordenador",
            "Kris: Yo primero por si pasa algo",
            "Ralsei: Os sigo por detrás"
        ];
        break;
    case "Lv5":
        if (!global.sala5_dialogue_completed) {
            dialogos = [
                "Ordenador: JAJAJAJA te has quedado sin la habilidad de moverte libremente",
                "Ordenador: Has de indicar con quién deseas moverte usando 1 y 2",
                "Ordenador: Hay 4 tipos de comandos\nDelay, move_to de entrenamiento fácil.\nAhora sin confundir P y V.",
                "Susie: P hace que tú puedas recoger la llave global para ti\nLa puerta",
                "Susie: V devuelves la llave a general para que otros lo puedan usar.\nEl guardador de llaves",
                "Ordenador: Ya se ve que estás entendiendo el mundo que te rodea.",
                "Susie: Concurrencia con el uso de sistema de Dijkstra"
            ];
        } else {
            dialogos = [];
            finished = true;
        }
        break;
    case "Lv6":
        if (!global.sala6_dialogue_completed) {
            dialogos = [
                "Ordenador: HAHAHAHA! Siempre pasas las cosas súper rápido!",
                "Ordenador: Debes de quedarte a hacer las cosas bien.",
                "Ordenador: ¡Usa el delay!"
            ];
        } else {
            dialogos = [];
            finished = true;
        }
        break;
    default:
        dialogos = [];
        break;
}

// Establecer diálogo inicial
if (dialog_index < array_length(dialogos) && dialog_full == "") {
    dialog_full = dialogos[dialog_index];
    dialog_text = "";
    dialog_pos = 0;
}

// Procesar diálogo (typewriter effect para Ordenador)
if (!finished && string_pos("Ordenador:", dialog_full) == 1) {
    dialog_timer += 1;
    if (dialog_timer >= dialog_speed && dialog_pos < string_length(dialog_full)) {
        dialog_pos += 1;
        dialog_text = string_copy(dialog_full, 1, dialog_pos);
        dialog_timer = 0;
    }
}

// Si ya terminó de escribir o es un diálogo de personaje, y el jugador pulsa una tecla
if (keyboard_check_pressed(vk_space)) {
    if (dialog_pos >= string_length(dialog_full) || string_pos("Susie:", dialog_full) == 1 || string_pos("Kris:", dialog_full) == 1 || string_pos("Ralsei:", dialog_full) == 1) {
        dialog_index += 1;
        if (dialog_index < array_length(dialogos)) {
            dialog_full = dialogos[dialog_index];
            dialog_text = "";
            dialog_pos = 0;
        } else {
            finished = true;
            if (current_room == "Lv4") {
                room_goto(Lv5); // Transición a Lv5
            } else if (current_room == "Lv5") {
                global.sala5_dialogue_completed = true;
            } else if (current_room == "Lv6") {
                global.sala6_dialogue_completed = true;
            }
            global.msg_text = ""; // Limpiar burbuja
            global.msg_speaker = noone;
        }
    } else if (string_pos("Ordenador:", dialog_full) == 1) {
        // Si presiona espacio antes de terminar, muestra todo de golpe
        dialog_pos = string_length(dialog_full);
        dialog_text = dialog_full;
    }
}

// Manejar diálogos de personajes mediante burbujas
if (dialog_index < array_length(dialogos)) {
    var current_dialog = dialogos[dialog_index];
    if (string_pos("Susie:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 7); // Quitar "Susie: "
        global.msg_speaker = oSusie;
        global.msg_timer = room_speed;
    } else if (string_pos("Kris:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 6); // Quitar "Kris: "
        global.msg_speaker = oKris;
        global.msg_timer = room_speed;
    } else if (string_pos("Ralsei:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 8); // Quitar "Ralsei: "
        global.msg_speaker = oRalsei;
        global.msg_timer = room_speed;
    } else if (string_pos("Ordenador:", current_dialog) == 1) {
        global.msg_text = ""; // No usar burbuja para el ordenador
        global.msg_speaker = noone;
    }
}

// Aparición de personajes en ciertos diálogos (solo para Start)
if (current_room == "Start") {
    switch (dialog_index) {
        case 1: show_ralsei = true; break;
        case 2: show_susie = true; break;
        case 3: show_kris = true; break;
    }
    // Actualizar visibilidad en tiempo real
    if (instance_exists(oRalsei)) oRalsei.visible = show_ralsei;
    if (instance_exists(oSusie)) oSusie.visible = show_susie;
    if (instance_exists(oKris)) oKris.visible = show_kris;
}

// Transición a Logic desde Start
if (finished && current_room == "Start" && global.susie_cama && global.ralsei_cama && global.kris_cama) {
    room_goto(Logic);
}

// Reiniciar sala en Lv3
if (current_room == "Lv3") {
    switch (dialog_index) {
        case 4: room_restart(); global.lv3_dialogue_completed = true; break;
    }
}