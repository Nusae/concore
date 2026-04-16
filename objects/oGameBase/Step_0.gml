// --- Lógica Base (Debug, Reinicio y Victoria) ---

// Tecla F4 para alternar pantalla completa
if (keyboard_check_pressed(vk_f4)) {
    window_set_fullscreen(!window_get_fullscreen());
}


// Teclas 1-4 para llaves (Ayuda al testeo)
if (keyboard_check_pressed(ord("1"))) {
    global.keys_golden += 1;
    show_debug_message("Llaves doradas: " + string(global.keys_golden));
}
if (keyboard_check_pressed(ord("2"))) {
    if (global.keys_golden > 0) global.keys_golden -= 1;
    show_debug_message("Llaves doradas: " + string(global.keys_golden));
}
if (keyboard_check_pressed(ord("3"))) {
    global.keys_gray += 1;
    show_debug_message("Llaves grises: " + string(global.keys_gray));
}
if (keyboard_check_pressed(ord("4"))) {
    if (global.keys_gray > 0) global.keys_gray -= 1;
    show_debug_message("Llaves grises: " + string(global.keys_gray));
}

// Tecla 8 para Reiniciar nivel
if (keyboard_check_pressed(ord("8"))) {
    global.show_fail_window = false;
    global.explode = false;
    room_restart(); 
}

// Condición de Victoria / Sentado (3 personajes sentados)
var victoria = (global.sentado_kris == 1 && global.sentado_susie == 1 && global.sentado_ralsei == 1);
if(global.explode || victoria){
    global.show_fail_window = true;
    
    // Forzar sprites de sentados si existen los objetos
    if (instance_exists(oKris)) oKris.sprite_index = sKrisSat;
    if (instance_exists(oSusie)) oSusie.sprite_index = sSusieSat;
    if (instance_exists(oRalsei)) oRalsei.sprite_index = sRalseiSat;
}
