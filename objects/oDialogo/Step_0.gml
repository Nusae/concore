event_inherited();

var current_room = room_get_name(room);

if (current_room == "Start") {
    switch(dialog_index) {
        case 1: show_ralsei = true; break;
        case 2: show_susie = true; break;
        case 3: show_kris   = true; break;
    }
    if (instance_exists(oRalsei)) oRalsei.visible = show_ralsei;
    if (instance_exists(oSusie)) oSusie.visible = show_susie;
    if (instance_exists(oKris)) oKris.visible = show_kris;
    
    if (finished && global.susie_cama && global.ralsei_cama && global.kris_cama ) {
        room_goto(Logic);
    }
}

if (current_room == "Lv3" && finished) {
    room_restart(); 
    global.lv3_dialogue_completed = true;
}