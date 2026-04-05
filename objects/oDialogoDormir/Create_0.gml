event_inherited();

// Determinar el diálogo basado en la sala actual
var current_room = room_get_name(room);

switch (current_room) {
    case "Sleep":
        dialogos = [
            "Ralsei: Menudo dia de trabajo",
            "Susie: Y que lo digas pero todo esta bien",
            "Kris: Seguro...",
            "Ralsei: Zzzz", 
            "Susie: Zzzz", 
            "Kris: 3 horas más tarde", 
            "Ralsei: Zzzz",
            "Kris: Susie, ¿puedes venir conmigo?", 
            "Susie: Pero si no hemos visto nada", 
            "Kris: Pero...",
            "Susie: Vamos", 
        ];
        
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
        break; 
    default:
        dialogos = ["Sala no reconocida."];
        show_ralsei = true;
        show_susie = true;
        show_kris = true;
        break;
}

if (current_room == "Sleep") {
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
