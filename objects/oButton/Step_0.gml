// Aseguramos variables locales
if (!variable_instance_exists(id, "completed")) completed = false;
if (!variable_instance_exists(id, "pressed")) pressed = false;
if (!variable_instance_exists(id, "timer")) timer = 0;
if (!variable_instance_exists(id, "debug_timer")) debug_timer = 0; // Temporizador para mensajes

// Depuración inicial
show_debug_message("Step ejecutándose para Botón " + string(id) + ", tempmode: " + string(global.tempmode));

// ===================================
// 🟢 MODO NORMAL (cada botón independiente)
// ===================================
if (!completed) {
    var local_counter = 0;

    // Contar personajes en el botón local usando distancia
    if (instance_exists(oKris) && point_distance(x, y, oKris.x, oKris.y) <= 30)   local_counter += 1;
    if (instance_exists(oRalsei) && point_distance(x, y, oRalsei.x, oRalsei.y) <= 30) local_counter += 1;
    if (instance_exists(oSusie) && point_distance(x, y, oSusie.x, oSusie.y) <= 30)  local_counter += 1;

    // Reacciones según número de personajes
    if (local_counter == 0) {
        sprite_index = sButtonUnPressed;
        image_speed = 0.1;
    } 
    else if (local_counter == 1) {
        sprite_index = sButtonPressed;
        image_speed = 0.1;

        // Mantener la animación hasta el último frame
        if (image_index < image_number - 1) {
            image_index += image_speed;
        } else {
            image_index = image_number - 1;
            image_speed = 0;
            completed = true; // se queda presionado
        }
    } 
    else if (local_counter >= 2) {
        sprite_index = sBoom;
        image_speed = 1;

        if (image_index < image_number - 1) {
            image_index += image_speed;
        } else {
            image_index = image_number - 1;
            image_speed = 0;
        }

        show_debug_message("💥 ¡BOOM! Demasiados procesos en un mismo botón.");
        global.explode = true;
        global.show_fail_window = true;
    }
} 
else {
    // Mantener el botón presionado permanentemente
    sprite_index = sButtonPressed;
    image_index = image_number - 1;
    image_speed = 0;
}

// ===================================
// 🔴 DETECCIÓN GLOBAL DE EXPLOSIÓN CON TEMPMODE
// ===================================
if (global.tempmode) {
    var buttons_total = instance_number(oButton);
    show_debug_message("Número total de botones: " + string(buttons_total));
    var personajes_en_botones = 0;

    with (oButton) {
        var local_count = 0; // Variable local para cada instancia
        if (instance_exists(oKris) && point_distance(x, y, oKris.x, oKris.y) <= 30)   local_count += 1;
        if (instance_exists(oRalsei) && point_distance(x, y, oRalsei.x, oRalsei.y) <= 30) local_count += 1;
        if (instance_exists(oSusie) && point_distance(x, y, oSusie.x, oSusie.y) <= 30)  local_count += 1;
        personajes_en_botones += local_count; // Sumar al total global
        show_debug_message("Botón " + string(id) + ": Detectados " + string(local_count) + " personajes localmente");
    }
    show_debug_message("Total personajes en botones antes de chequeo: " + string(personajes_en_botones));

    if (personajes_en_botones >= 2) {
        show_debug_message("💥 ¡BOOM GLOBAL! Dos o más personajes están sobre botones en tempmode.");
        global.explode = true;
        global.show_fail_window = true;

        with (oButton) {
            sprite_index = sBoom;
            image_speed = 1;
            if (image_index < image_number - 1) {
                image_index += image_speed;
            } else {
                image_index = image_number - 1;
                image_speed = 0;
            }
        }
        // Temporizador para mostrar mensaje sin pausar el juego
        if (debug_timer < 60) { // Mostrar mensaje por 1 segundo (a 60 fps)
            debug_timer += 1;
            show_debug_message("Explosión activada, esperando... " + string(debug_timer));
        }
    } else {
        debug_timer = 0; // Resetear si no hay explosión
    }
}// Aseguramos variables locales
if (!variable_instance_exists(id, "completed")) completed = false;
if (!variable_instance_exists(id, "pressed")) pressed = false;
if (!variable_instance_exists(id, "timer")) timer = 0;
if (!variable_instance_exists(id, "debug_timer")) debug_timer = 0; // Temporizador para mensajes

// Depuración inicial
show_debug_message("Step ejecutándose para Botón " + string(id) + ", tempmode: " + string(global.tempmode));

// ===================================
// 🟢 MODO NORMAL (cada botón independiente)
// ===================================
if (!completed) {
    var local_counter = 0;

    // Contar personajes en el botón local usando distancia
    if (instance_exists(oKris) && point_distance(x, y, oKris.x, oKris.y) <= 30)   local_counter += 1;
    if (instance_exists(oRalsei) && point_distance(x, y, oRalsei.x, oRalsei.y) <= 30) local_counter += 1;
    if (instance_exists(oSusie) && point_distance(x, y, oSusie.x, oSusie.y) <= 30)  local_counter += 1;

    // Reacciones según número de personajes
    if (local_counter == 0) {
        sprite_index = sButtonUnPressed;
        image_speed = 0.1;
    } 
    else if (local_counter == 1) {
        sprite_index = sButtonPressed;
        image_speed = 0.1;

        // Mantener la animación hasta el último frame
        if (image_index < image_number - 1) {
            image_index += image_speed;
        } else {
            image_index = image_number - 1;
            image_speed = 0;
            completed = true; // se queda presionado
        }
    } 
    else if (local_counter >= 2) {
        sprite_index = sBoom;
        image_speed = 1;

        if (image_index < image_number - 1) {
            image_index += image_speed;
        } else {
            image_index = image_number - 1;
            image_speed = 0;
        }

        show_debug_message("💥 ¡BOOM! Demasiados procesos en un mismo botón.");
        global.explode = true;
        global.show_fail_window = true;
    }
} 
else {
    // Mantener el botón presionado permanentemente
    sprite_index = sButtonPressed;
    image_index = image_number - 1;
    image_speed = 0;
}

// ===================================
// 🔴 DETECCIÓN GLOBAL DE EXPLOSIÓN CON TEMPMODE
// ===================================
if (global.tempmode) {
    var buttons_total = instance_number(oButton);
    show_debug_message("Número total de botones: " + string(buttons_total));
    var personajes_en_botones = 0;

    with (oButton) {
        var local_count = 0; // Variable local para cada instancia
        if (instance_exists(oKris) && point_distance(x, y, oKris.x, oKris.y) <= 30)   local_count += 1;
        if (instance_exists(oRalsei) && point_distance(x, y, oRalsei.x, oRalsei.y) <= 30) local_count += 1;
        if (instance_exists(oSusie) && point_distance(x, y, oSusie.x, oSusie.y) <= 30)  local_count += 1;
        personajes_en_botones += local_count; // Sumar al total global
        show_debug_message("Botón " + string(id) + ": Detectados " + string(local_count) + " personajes localmente");
    }
    show_debug_message("Total personajes en botones antes de chequeo: " + string(personajes_en_botones));

    if (personajes_en_botones >= 2) {
        show_debug_message("💥 ¡BOOM GLOBAL! Dos o más personajes están sobre botones en tempmode.");
        global.explode = true;
        global.show_fail_window = true;

        with (oButton) {
            sprite_index = sBoom;
            image_speed = 1;
            if (image_index < image_number - 1) {
                image_index += image_speed;
            } else {
                image_index = image_number - 1;
                image_speed = 0;
            }
        }
        // Temporizador para mostrar mensaje sin pausar el juego
        if (debug_timer < 60) { // Mostrar mensaje por 1 segundo (a 60 fps)
            debug_timer += 1;
            show_debug_message("Explosión activada, esperando... " + string(debug_timer));
        }
    } else {
        debug_timer = 0; // Resetear si no hay explosión
    }
}