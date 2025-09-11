// Contar cuántos personajes están encima del botón
var count = 0;

// Revisamos si hay personajes (usando una lista de objetos específicos)
if (place_meeting(x, y, oKris)) count += 1;
if (place_meeting(x, y, oRalsei)) count += 1;
if (place_meeting(x, y, oSusie)) count += 1;

// Reaccionar según el número de personajes encima
if (count == 0) {
    sprite_index = sSwitchUnPressed;
    image_speed = 1; // Velocidad de animación normal
} else if (count == 1) {
    sprite_index = sSwitchPressed; 
	image_speed = 1; // Velocidad de animación normal
} else if (count == 2) {
    sprite_index = sSwitchPressed;
    image_speed = 2; // Duplicar la velocidad de animación (FPS del objeto)
    show_debug_message("¡Dos personajes! Velocidad de animación duplicada.");
} else if (count >= 3) {
    sprite_index = sBoom;
    image_speed = 1;
    show_debug_message("¡BOOM! Explosión por tres personajes.");
    
    global.explode = true;          // Flag de explosión
    global.show_fail_window = true; // Activamos ventana de fallo
}