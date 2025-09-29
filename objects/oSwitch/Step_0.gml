// Reiniciamos el contador global del switch
global.counter_switch = 0;

// Revisamos si hay personajes (usando una lista de objetos específicos)
if (place_meeting(x, y, oKris))   global.counter_switch += 1;
if (place_meeting(x, y, oRalsei)) global.counter_switch += 1;
if (place_meeting(x, y, oSusie))  global.counter_switch += 1;

// Reaccionar según el número de personajes encima
if (global.counter_switch == 0) {
    sprite_index = sSwitchUnPressed;
    image_speed = 1; // Velocidad de animación normal
} 
else if (global.counter_switch == 1) {
    sprite_index = sSwitchPressed; 
    image_speed = 1; // Velocidad de animación normal
} 
else if (global.counter_switch == 2) {
    sprite_index = sSwitchPressed;
    image_speed = 2; // Duplicar la velocidad de animación (FPS del objeto)
    show_debug_message("¡Dos personajes! Velocidad de animación duplicada.");
} 
else if (global.counter_switch >= 3) {
    sprite_index = sBoom;
    image_speed = 1;
    show_debug_message("¡BOOM! Explosión por tres personajes.");
    
    global.explode = true;          // Flag de explosión
    global.show_fail_window = true; // Activamos ventana de fallo
}

// Verificar si hay algún personaje encima (oKris, oRalsei, oSusie)
if (place_meeting(x, y, oKris) || place_meeting(x, y, oRalsei) || place_meeting(x, y, oSusie)) {
    if (!pressed) {
        pressed = true;
        timer = 0;
    } else {
        timer += 1;
    }
} else {
    pressed = false;
    timer = 0;
}

// Verificar si la tarea está completada
if (!completed && timer >= required_time) {
    completed = true;
    sprite_index = sButtonUnPressed;
    show_debug_message("Botón completado después de " + string(required_time / room_speed) + " segundos");
}


