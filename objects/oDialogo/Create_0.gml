// Determinar el diálogo basado en la sala actual
var current_room = room_get_name(room);

// Initialize global.lv3_dialogue_completed when entering Lv3 for the first time
if (current_room == "Lv3" && !variable_global_exists("lv3_dialogue_completed")) {
    global.lv3_dialogue_completed = false; // Only initialize if not already set
}

dialogos = []; // Inicializar vacío

switch (current_room) {
    case "Start":
        dialogos = [
            "Buenas a todos, hoy presentare unos temas de concurrencia [espacio]",
            "Yo soy Ralsei me muevo con WASD",
            "Yo soy Susie me muevo con UHJK",
            "Y finalmente yo, Kris me muevo con las flechas",
			"Z,X,C permite hacer cambio de viewpoints",
			"Acompañalos a sus camas",
        ];
        // En Start, personajes aparecen progresivamente
        show_ralsei = false;
        show_susie = false;
        show_kris = false;
		
        break;
   
    default:
        // Diálogo por defecto si la sala no coincide (puedes ajustar)
        dialogos = ["Sala no reconocida."];
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

// Control para saber si ya se mostró todo
finished = false;

if (string_length(dialog_full) > 0) {
    dialog_pos = 1;
    dialog_text = string_copy(dialog_full, 1, dialog_pos);
}
if (room_get_name(room) == "Start") {
	// Otras inicializaciones globales y de objetos
	global.commandmode = false; 
	global.keys_golden = 1; // Llaves doradas
	global.keys_gray = 2;   // Llaves grises
	global.sentado_susie = 0;
	global.sentado_kris = 0;
	global.sentado_ralsei = 0; 
	personaje = 3; 
	global.show_fail_window = false; 
	oKris.keys_golden = 0; 
	oKris.keys_gray = 0;
	oSusie.keys_golden = 0; 
	oSusie.keys_gray = 0;
	oRalsei.keys_golden = 0; 
	oRalsei.keys_gray = 0;
	oKris.visible = show_kris; 
	oSusie.visible = show_susie; 
	oRalsei.visible = show_ralsei;
}
