// Determinar el diálogo basado en la sala actual
var current_room = room_get_name(room);

dialogos = []; // Inicializar vacío

switch (current_room) {
    case "Start":
        dialogos = [
            "Buenas a todos, hoy presentare unos temas de concurrencia,",
            "Yo soy Ralsei me muevo con WASD",
            "Yo soy Susie me muevo con UHJK",
            "Y finalmente yo, Kris me muevo con las flechas",
            "En esta representación las puertas son las P (recoge una llave general)",
            "Y los guardadores de llave las V (deja la llave en general)\nEspero que esto te ayude"
        ];
        // En Start, personajes aparecen progresivamente
        show_ralsei = false;
        show_susie = false;
        show_kris = false;
        break;
    
    case "Lv1":
        dialogos = [
            "Hemos de pasar por los niveles, pero hay ciertas normas; \nsolo puede haber una persona encima del boton,\n y hasta 2 en los switches sino explota.",
            "Se puede elegir la cantidad de color de llaves con 1 2 3 4.\n ¡Busca la opción más óptima!",
            "¡Llega a las metas y gana!",
        ];
        // En otros niveles, personajes visibles desde el inicio
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
        break;
    
    case "Lv2":
        dialogos = [
            "Bienvenido al segundo nivel.",
            "No hay llave general en esta sala",
            "Pero Kris tiene una",
            "¿Este es el tipo de problema de sincronización, que vas a hacer?"
        ];
        show_susie = true;
        show_kris = true;
        break;
    
    case "Lv3":
        dialogos = [
            "Aparece en la tercera sala",
            "Piensa antes de actuar",
            "Este es un problema muy típico; ¡Interbloqueo!"
        ];
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
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
dialog_full = dialogos[dialog_index];
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
sprite_index = sWall ; 
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
