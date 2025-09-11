// Contar cuántos personajes están encima del botón
var count = 0;

// Revisamos si hay personajes (usando una lista de objetos específicos)
if (place_meeting(x, y, oKris)) count += 1;
if (place_meeting(x, y, oRalsei)) count += 1;
if (place_meeting(x, y, oSusie)) count += 1;

// Reaccionar según el número de personajes encima
if (count == 0) {
    sprite_index = sButtonUnPressed;
} else if (count == 1) {
    sprite_index = sButtonPressed;
} else if (count >= 2) {
    sprite_index = sBoom;
    global.explode = true;
    show_debug_message("¡BOOM! Demasiados procesos.");
	global.show_fail_window = true;
}
