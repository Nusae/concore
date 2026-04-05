event_inherited();

// Determinar el diálogo basado en la sala actual
var current_room = room_get_name(room);

// Initialize global.lv3_dialogue_completed when entering Lv3 for the first time
if (current_room == "Lv3" && !variable_global_exists("lv3_dialogue_completed")) {
    global.lv3_dialogue_completed = false; 
}

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
        show_ralsei = false;
        show_susie = false;
        show_kris = false;
        break;
   
    default:
        dialogos = ["Sala no reconocida."];
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
        break;
}

if (current_room == "Start") {
    global.commandmode = false; 
    global.keys_golden = 1; 
    global.keys_gray = 2;   
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
