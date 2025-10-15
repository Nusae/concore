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

current_room = room_get_name(room); 

// Initialize global.lv3_dialogue_completed when entering Lv3 for the first time
if (current_room == "Lv3" && !variable_global_exists("lv3_dialogue_completed")) {
    global.lv3_dialogue_completed = false; // Only initialize if not already set
}
// Inicializar visibilidad de oGoldS
if (!variable_instance_exists(id, "gold_s_visible")) {
    gold_s_visible = false;
}

// Definir diálogos por sala
if (room_get_name(room) == "Lv1") {
    dialogos = [
        "Ordenador: Este es el último nivel",
        "Ordenador: Os acordáis de vuestro sistema de botones y palancas",
        "Ordenador: Pues ahora tenéis que decidir cuántas llaves quieres de oro y grises",
        "Ordenador: Para pasar por aquí tendrás que decidir cuántas llaves quieres con las teclas 1234"
    ];
} else if (room_get_name(room) == "Lv2") {
    dialogos = [
        "Susie: Hay una puerta aquí que no puedo pasar",
        "Ordenador: JAJAJAJA aún con un amigo avisándote no te diste cuenta",
        "Ordenador: Ahora tengo el control entero de la nave", 
        "Ordenador: Muestra tus habilidades para ganarme, prueba a ver si llegas al núcleo", 
        "Ordenador: Te tengo una sorpresa esperándote",
        "Kris: He encontrado una llave", 
        "Susie: Pásamelo", 
        "Kris: ¿Pero estás lejos, cómo puedo pasártelo?", 
        "Susie: Busca un lugar para dejarla",
        "Kris: Veo una caja gris", 
        "Susie: Pon la llave ahí", 
        "Susie: Mira, ahora la puedo ver, está en las llaves generales.",
        "Susie: Ahora puedo salir por la puerta",
        "Ordenador: Este ha sido solo el primer nivel, sincronización",
        "Ordenador: ¡Los demás serán más complicados!",
    ];
} else if (room_get_name(room) == "Lv3" && !global.lv3_dialogue_completed) {
    dialogos = [
        "Ralsei: He escuchado ruido y he venido lo antes posible",
        "Ralsei: ¿Os encontráis bien?",
        "Kris: Sí, todo bien, es el sistema como dije",
        "Kris: Pero no me habéis oído y ahora el ordenador tiene control de nave",
        "Susie: No es el ordenador, es un virus, un troyano, no es el ordenador propio",
        "Todos: ¡Vamos!",
        "Todos: Nos acabamos de quedar atrapados, todos tenemos una llave pero falta otra puerta",
        "Ordenador: Interbloqueo, seré bueno con el 8, podéis repetir los niveles"
    ];
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
    if (dialog_pos >= string_length(dialog_full) || string_pos("Susie:", dialog_full) == 1 || string_pos("Kris:", dialog_full) == 1 || string_pos("Ralsei:", dialog_full) == 1 || string_pos("Todos:", dialog_full) == 1) {
        dialog_index += 1;
        if (dialog_index < array_length(dialogos)) {
            dialog_full = dialogos[dialog_index];
            dialog_text = "";
            dialog_pos = 0;
        } else {
            finished = true;
            if (room_get_name(room) == "Lv2") global.lv2_dialogue_completed = true;
            if (room_get_name(room) == "Lv3") global.lv3_dialogue_completed = true;
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
    } else if (string_pos("Todos:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 7); // Quitar "Todos: "
        global.msg_speaker = self; // Usar self para Todos (posición genérica)
        global.msg_timer = room_speed;
    } else if (string_pos("Ordenador:", current_dialog) == 1) {
        global.msg_text = ""; // No usar burbuja para el ordenador
        global.msg_speaker = noone;
    }
}

// Controlar visibilidad de oGoldS (caja gris) en Lv2
if (room_get_name(room) == "Lv2") {
    switch (dialog_index) {
        case 9: gold_s_visible = true; break; // "Kris: Veo una caja gris"
    }
    if (instance_exists(oGoldS)) {
        oGoldS.visible = gold_s_visible;
    }
}

// Aparición de personajes en ciertos diálogos (solo para Start)
if (room_get_name(room) == "Start") {
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
if (finished && room_get_name(room) == "Start" && global.susie_cama && global.ralsei_cama && global.kris_cama) {
    room_goto(Logic);
}

// Reiniciar sala en Lv3
if (room_get_name(room) == "Lv3") {
    switch (dialog_index) {
        case 8: room_restart(); global.lv3_dialogue_completed = true; break;
    }
}