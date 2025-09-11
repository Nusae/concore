
// Tecla 1 → Agregar una llave dorada
if (keyboard_check_pressed(ord("1"))) {
    global.keys_golden += 1;
    show_debug_message("Llaves doradas: " + string(global.keys_golden));
}

// Tecla 2 → Quitar una llave dorada (si hay)
if (keyboard_check_pressed(ord("2"))) {
    if (global.keys_golden > 0) {
        global.keys_golden -= 1;
    }
    show_debug_message("Llaves doradas: " + string(global.keys_golden));
}

// Tecla 3 → Agregar una llave gris
if (keyboard_check_pressed(ord("3"))) {
    global.keys_gray += 1;
    show_debug_message("Llaves grises: " + string(global.keys_gray));
}

// Tecla 4 → Quitar una llave gris (si hay)
if (keyboard_check_pressed(ord("4"))) {
    if (global.keys_gray > 0) {
        global.keys_gray -= 1;
    }
    show_debug_message("Llaves grises: " + string(global.keys_gray));
}


//Logica de la pantalla de fallo
if (global.show_fail_window) {
    
    
    if (keyboard_check_pressed(ord("8"))) {
        global.show_fail_window = false;
        global.explode = false;
        room_restart(); 
    }
}
