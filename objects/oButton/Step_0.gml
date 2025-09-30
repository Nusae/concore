// Reiniciamos el contador global
global.counter_button = 0;

// Revisamos si hay personajes (usando una lista de objetos específicos)
if (place_meeting(x, y, oKris))   global.counter_button += 1;
if (place_meeting(x, y, oRalsei)) global.counter_button += 1;
if (place_meeting(x, y, oSusie))  global.counter_button += 1;

// Reaccionar según el número de personajes encima
if (global.counter_button == 0) {
    sprite_index = sButtonUnPressed;
} 
else if (global.counter_button == 1) {
    sprite_index = sButtonPressed;
	completed = true; 
} 
else if (global.counter_button >= 2) {
    sprite_index = sBoom;
    global.explode = true;
    show_debug_message("¡BOOM! Demasiados procesos.");
    global.show_fail_window = true;
}

// Verificar si hay algún personaje encima (oKris, oRalsei, oSusie)
if(global.tempmode){
	
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
}
