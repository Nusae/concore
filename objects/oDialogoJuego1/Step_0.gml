
// EVENTO STEP
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
if (!variable_global_exists("lv2_dialogue_completed")) global.lv2_dialogue_completed = false;
if (!variable_global_exists("lv3_dialogue_completed")) global.lv3_dialogue_completed = false;
if (!variable_global_exists("lv4_dialogue_completed")) global.lv4_dialogue_completed = false;

// Inicializar visibilidad de oGoldS
if (!variable_instance_exists(id, "gold_s_visible")) {
    gold_s_visible = false;
}

// Definir diálogos por sala
var current_room = room_get_name(room);
switch (current_room) {
    case "Lv1":
        dialogos = [
            "Ordenador: Este es el último nivel",
            "Ordenador: Os acordáis de vuestro sistema de botones y palancas",
			"Sistema: Recuerda puede haber hasta dos personajes en la zona con Switch", 
            "Ordenador: Pues ahora tenéis que decidir cuántas llaves quieres de oro y grises",
            "Sistema: Para pasar por aquí tendrás que decidir cuántas llaves quieres con las teclas 1234"
        ];
        break;
    case "Lv2":
        dialogos = [
            "Sistema: Lleva a Susie a la puerta, no hagas nada con Kris",
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
            "Sistema: Lleva a Kris a la caja gris",
            "Susie: Pon la llave ahí", 
            "Susie: Mira, ahora la puedo ver, está en las llaves generales.",
            "Susie: Ahora puedo salir por la puerta",
            "Ordenador: Este ha sido solo el primer nivel, sincronización",
            "Ordenador: ¡Los demás serán más complicados!"
        ];
        break;
    case "Lv3":
        if (!global.lv3_dialogue_completed) {
            dialogos = [
                "Sistema: No muevas los personajes aún",
                "Ralsei: He escuchado ruido y he venido lo antes posible",
                "Ralsei: ¿Os encontráis bien?",
                "Kris: Sí, todo bien, es el sistema como dije",
                "Kris: Pero no me habéis oído y ahora el ordenador tiene control de nave",
                "Susie: No es el ordenador, es un virus, un troyano, no es el ordenador propio",
                "Todos: ¡Vamos!",
                "Sistema: Mueve a los personajes a la puerta más cercana",
                "Todos: Nos acabamos de quedar atrapados, todos tenemos una llave pero falta otra puerta",
                "Ordenador: Interbloqueo, seré bueno con el 8, podéis repetir los niveles"
            ];
        } else {
            dialogos = [];
            finished = true;
        }
        break;
    case "Lv4":
        if (!global.lv4_dialogue_completed) {
            dialogos = [
                "Susie: Mira ahí está el ordenador",
                "Kris: Yo primero por si pasa algo",
                "Ralsei: Os sigo por detrás"
            ];
        } else {
            dialogos = [];
            finished = true;
        }
        break;
    default:
        dialogos = [
            "Susie: Mira ahí está el ordenador",
            "Kris: Yo primero por si pasa algo",
            "Ralsei: Os sigo por detrás"
        ];
        break;
}

// Establecer diálogo inicial
if (dialog_index < array_length(dialogos) && dialog_full == "") {
    dialog_full = dialogos[dialog_index];
    dialog_text = dialog_full; // Mostrar todo el texto de inmediato, excepto para Ordenador
    dialog_pos = string_length(dialog_full); // Completar la posición para diálogos no-Ordenador
    show_debug_message("Inicializando diálogo: dialog_full = " + dialog_full + ", dialog_text = " + dialog_text);
}

// Procesar diálogo (typewriter effect solo para Ordenador)
if (!finished && string_pos("Ordenador:", dialog_full) == 1) {
    dialog_timer += 1;
    if (dialog_timer >= dialog_speed && dialog_pos < string_length(dialog_full)) {
        dialog_pos += 1;
        dialog_text = string_copy(dialog_full, 1, dialog_pos);
        dialog_timer = 0;
        show_debug_message("Procesando typewriter: dialog_text = " + dialog_text);
    }
}

// Si el jugador pulsa una tecla
if (keyboard_check_pressed(vk_space)) {
    if (dialog_pos >= string_length(dialog_full) || string_pos("Susie:", dialog_full) == 1 || string_pos("Kris:", dialog_full) == 1 || string_pos("Ralsei:", dialog_full) == 1 || string_pos("Todos:", dialog_full) == 1 || string_pos("Sistema:", dialog_full) == 1) {
        dialog_index += 1;
        if (dialog_index < array_length(dialogos)) {
            dialog_full = dialogos[dialog_index];
            dialog_text = dialog_full; // Mostrar todo el texto de inmediato, excepto para Ordenador
            dialog_pos = string_length(dialog_full);
            show_debug_message("Avanzando diálogo: dialog_index = " + string(dialog_index) + ", dialog_text = " + dialog_text);
        } else {
            finished = true;
            if (current_room == "Lv2") global.lv2_dialogue_completed = true;
            if (current_room == "Lv3") global.lv3_dialogue_completed = true;
            if (current_room == "Lv4") {
                global.lv4_dialogue_completed = true;
                room_goto(Lv5); // Transición a Lv5
            }
            global.msg_text = ""; // Limpiar burbuja
            global.msg_speaker = noone;
            show_debug_message("Diálogos terminados");
        }
    } else if (string_pos("Ordenador:", dialog_full) == 1) {
        // Si presiona espacio antes de terminar, muestra todo de golpe
        dialog_pos = string_length(dialog_full);
        dialog_text = dialog_full;
        show_debug_message("Mostrando diálogo completo de Ordenador: dialog_text = " + dialog_text);
    }
}

// Manejar diálogos de personajes mediante burbujas
if (dialog_index < array_length(dialogos)) {
    var current_dialog = dialogos[dialog_index];
    if (string_pos("Susie:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 7); // Quitar "Susie: "
        global.msg_speaker = oSusie;
        global.msg_timer = room_speed;
        dialog_text = current_dialog; // Sincronizar para Draw
        show_debug_message("Configurando burbuja Susie: global.msg_text = " + global.msg_text);
    } else if (string_pos("Kris:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 6); // Quitar "Kris: "
        global.msg_speaker = oKris;
        global.msg_timer = room_speed;
        dialog_text = current_dialog;
        show_debug_message("Configurando burbuja Kris: global.msg_text = " + global.msg_text);
    } else if (string_pos("Ralsei:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 8); // Quitar "Ralsei: "
        global.msg_speaker = oRalsei;
        global.msg_timer = room_speed;
        dialog_text = current_dialog;
        show_debug_message("Configurando burbuja Ralsei: global.msg_text = " + global.msg_text);
    } else if (string_pos("Todos:", current_dialog) == 1) {
        global.msg_text = string_delete(current_dialog, 1, 7); // Quitar "Todos: "
        global.msg_speaker = self; // Usar self para Todos (posición genérica)
        global.msg_timer = room_speed;
        dialog_text = current_dialog;
        show_debug_message("Configurando burbuja Todos: global.msg_text = " + global.msg_text);
    } else if (string_pos("Ordenador:", current_dialog) == 1 || string_pos("Sistema:", current_dialog) == 1) {
        global.msg_text = ""; // No usar burbuja para Ordenador o Sistema
        global.msg_speaker = noone;
        dialog_text = current_dialog; // Asegurar que dialog_text se actualice
        show_debug_message("Configurando diálogo global (Ordenador/Sistema): dialog_text = " + dialog_text);
    }
}

// Controlar visibilidad de oGoldS (caja gris) en Lv2
if (current_room == "Lv2") {
    switch (dialog_index) {
        case 11: gold_s_visible = true; break; // "Kris: Veo una caja gris" (ajustado por el índice correcto)
    }
    if (instance_exists(oGoldS)) {
        oGoldS.visible = gold_s_visible;
    }
}

// Aparición de personajes en ciertos diálogos (solo para Start)
if (current_room == "Start") {
    switch (dialog_index) {
        case 1: show_ralsei = true; break;
        case 2: show_susie = true; break;
        case 3: show_kris = true; break;
    }
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
        case 10: room_restart(); global.lv3_dialogue_completed = true; break; // Ajustado por el índice correcto
    }
}

// --- BLOQUEO DE MOVIMIENTO SEGÚN DIÁLOGO ---
if (!finished) {
    if (current_room == "Lv2") {
        // Bloquear a Kris desde el inicio (0) hasta "Veo una caja gris" (10)
        if (dialog_index >= 0 && dialog_index <= 10) {
            global.kris_bloqueado = true;
        } else {
            global.kris_bloqueado = false;
        }
    } else {
        global.kris_bloqueado = false;
    }

    if (current_room == "Lv3") {
        // Bloquear a todos desde "No muevas..." (0) hasta "...virus, un troyano..." (5)
        if (dialog_index >= 0 && dialog_index <= 5) {
            global.movimiento_bloqueado = true;
        } else {
            global.movimiento_bloqueado = false;
        }
    } else {
        global.movimiento_bloqueado = false;
    }
} else {
    global.movimiento_bloqueado = false;
    global.kris_bloqueado = false;
}
