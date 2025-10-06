// Determinar el diálogo basado en la sala actual
var current_room = room_get_name(room);

// Inicializar variable global solo una vez
if (current_room == "Lv5" && !variable_global_exists("sala5_dialogue_completed")) {
    global.sala5_dialogue_completed = false;
}
if (current_room == "Lv6" && !variable_global_exists("sala6_dialogue_completed")) {
    global.sala6_dialogue_completed = false;
}

dialogos = []; // Inicializar vacío

switch (current_room) {
    case "Lv5":
        if (!global.sala5_dialogue_completed) {
            dialogos = [
                "Oh no, te han quitado la habilidad de moverte libremente \n Has de hacer uso de los commandos",
                "Has de indicar con quien deseas moverte usando 1 y 2", 
				"Hay 4 tipos de commandos\n Delay, move_to de entienimiento facil.\n Ahora sin confudir P y V.", 
				"P hace que tu puedas recoger la llave global para ti\n La puerta", 
				"V devuelves la llave a general para que otros lo puedan usar.\nEl guardadord de llaves" 
            ];
        } else {
            dialogos = [];
            finished = true; // Omitir diálogo si ya fue mostrado
        }
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
        break;

    case "Lv6":
        if (!global.sala6_dialogue_completed) {
            dialogos = [
                "HAHAHAHA! Siempre pasas las cosas super rápido!",
                "Debes de quedarte a hacer las cosas bien.", 
				"Usa el delay!"
            ];
        } else {
            dialogos = [];
            finished = true;
        }
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
        break;

    default:
        dialogos = [];
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
        break;
}

// índice del diálogo actual
dialog_index = 0;

// control de escritura tipo Undertale (una letra a la vez)
dialog_text = "";
dialog_full = (array_length(dialogos) > 0) ? dialogos[dialog_index] : "";
dialog_pos = 0;
dialog_speed = 2; // menor = más rápido
dialog_timer = 0;
finished = false;

// Si hay texto, iniciar la primera letra
if (string_length(dialog_full) > 0) {
    dialog_pos = 1;
    dialog_text = string_copy(dialog_full, 1, dialog_pos);
}

