event_inherited();

var current_room = room_get_name(room);

// 1. DEFINIR DIÁLOGOS POR SALA
if (array_length(dialogos) == 0 && !finished) {
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
            if (!variable_global_exists("lv3_dialogue_completed") || !global.lv3_dialogue_completed) {
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
            } else { finished = true; }
            break;
        case "Lv4":
            if (!variable_global_exists("lv4_dialogue_completed") || !global.lv4_dialogue_completed) {
                dialogos = [
                    "Susie: Mira ahí está el ordenador",
                    "Kris: Yo primero por si pasa algo",
                    "Ralsei: Os sigo por detrás"
                ];
            } else { finished = true; }
            break;
        default:
            dialogos = [
                "Susie: Mira ahí está el ordenador",
                "Kris: Yo primero por si pasa algo",
                "Ralsei: Os sigo por detrás"
            ];
            break;
    }
}

// 2. TRIGGERS DE FINALIZACIÓN
if (finished) {
    if (current_room == "Lv2") global.lv2_dialogue_completed = true;
    if (current_room == "Lv3") global.lv3_dialogue_completed = true;
    if (current_room == "Lv4") {
        global.lv4_dialogue_completed = true;
        room_goto(Lv5);
    }
}

// 3. BLOQUEO DE MOVIMIENTO
if (!finished) {
    if (current_room == "Lv2") {
        global.kris_bloqueado = (dialog_index >= 0 && dialog_index <= 10);
    } 
    if (current_room == "Lv3") {
        global.movimiento_bloqueado = (dialog_index >= 0 && dialog_index <= 5);
    }
} else {
    global.movimiento_bloqueado = false;
    global.kris_bloqueado = false;
}

// 4. OTROS TRIGGERS (Oro, Start)
if (current_room == "Lv2") {
    if (dialog_index == 11) gold_s_visible = true;
    if (instance_exists(oGoldS)) oGoldS.visible = gold_s_visible;
}

if (current_room == "Lv3") {
    if (dialog_index == 10 && finished) {
        room_restart();
        global.lv3_dialogue_completed = true;
    }
}
