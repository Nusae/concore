// Inicializamos variables si no existen
if (!variable_instance_exists(id, "completed")) completed = false;
if (!variable_instance_exists(id, "pressed")) pressed = false;
if (!variable_instance_exists(id, "timer")) timer = 0;
if (!variable_instance_exists(id, "counter_switch_local")) counter_switch_local = 0;
if (!variable_instance_exists(id, "debug_timer")) debug_timer = 0; // Temporizador para mensajes

// Depuración inicial
show_debug_message("Step ejecutándose para Switch " + string(id) + ", tempmode: " + string(global.tempmode));

// ==============================
// LÓGICA GENERAL (independiente de commandmode)
// ==============================
if (!completed) {
    counter_switch_local = 0;

    // Contar personajes en el switch local
    if (instance_exists(oKris) && point_distance(x, y, oKris.x, oKris.y) <= 30)   counter_switch_local += 1;
    if (instance_exists(oRalsei) && point_distance(x, y, oRalsei.x, oRalsei.y) <= 30) counter_switch_local += 1;
    if (instance_exists(oSusie) && point_distance(x, y, oSusie.x, oSusie.y) <= 30)  counter_switch_local += 1;

    if (counter_switch_local == 0) {
        sprite_index = sSwitchUnPressed;
        image_speed = 0.1;
    } 
    else if (counter_switch_local == 1) {
        sprite_index = sSwitchPressed;
        image_speed = 0.1;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
            completed = true;
        }
    } 
    else if (counter_switch_local == 2) {
        sprite_index = sSwitchPressed;
        image_speed = 0.2;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
            completed = true;
        }
    } 
    else if (counter_switch_local >= 3) {
        sprite_index = sBoom;
        image_speed = 1;
        if (image_index >= image_number - 1) {
            image_index = image_number - 1;
            image_speed = 0;
        }
        show_debug_message("¡BOOM individual!");
        global.explode = true;
        global.show_fail_window = true;
    }
} else {
    sprite_index = sSwitchPressed;
    image_index = image_number - 1;
    image_speed = 0;
}

// ==============================
// DETECCIÓN GLOBAL DE EXPLOSIÓN CON TEMPMODE
// ==============================
if (global.tempmode) {
    var switches_total = instance_number(oSwitch);
    show_debug_message("Número total de switches: " + string(switches_total));
    var personajes_en_switch = 0;

    with (oSwitch) {
        var local_count = 0; // Variable local para cada instancia
        if (instance_exists(oKris) && point_distance(x, y, oKris.x, oKris.y) <= 30)   local_count += 1;
        if (instance_exists(oRalsei) && point_distance(x, y, oRalsei.x, oRalsei.y) <= 30) local_count += 1;
        if (instance_exists(oSusie) && point_distance(x, y, oSusie.x, oSusie.y) <= 30)  local_count += 1;
        personajes_en_switch += local_count; // Sumar al total global
        show_debug_message("Switch " + string(id) + ": Detectados " + string(local_count) + " personajes localmente");
    }
    show_debug_message("Total personajes en switches antes de chequeo: " + string(personajes_en_switch));

    if (personajes_en_switch >= 3) {
        show_debug_message("¡BOOM GLOBAL! Los tres personajes están sobre switches en tempmode.");
        global.explode = true;
        global.show_fail_window = true;

        with (oSwitch) {
            sprite_index = sBoom;
            image_speed = 1;
            if (image_index >= image_number - 1) {
                image_index = image_number - 1;
                image_speed = 0;
            }
        }
        // Temporizador para mostrar mensaje sin pausar el juego
        if (debug_timer < 120) { // Mostrar mensaje por 1 segundo (a 60 fps)
            debug_timer += 1;
            show_debug_message("Explosión activada, esperando... " + string(debug_timer));
        }
    } else {
        debug_timer = 0; // Resetear si no hay explosión
    }
}