/// --- BUTTON STEP EVENT ---

// Aseguramos variables locales
if (!variable_instance_exists(id, "completed")) completed = false;
if (!variable_instance_exists(id, "pressed")) pressed = false;
if (!variable_instance_exists(id, "timer")) timer = 0;

// ===================================
// 🟢 MODO NORMAL (cada botón independiente)
// ===================================
if (!global.commandmode) {
    if (!completed) {
        var local_counter = 0;

        if (place_meeting(x, y, oKris))   local_counter += 1;
        if (place_meeting(x, y, oRalsei)) local_counter += 1;
        if (place_meeting(x, y, oSusie))  local_counter += 1;

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
}

// ===================================
// 🔴 MODO COMANDO (todos los botones cuentan juntos)
// ===================================
else {
    // Crear y reiniciar el contador global al principio del frame
    if (!variable_global_exists("counter_button_global")) global.counter_button_global = 0;

    // Contamos cuántos personajes están sobre este botón
    var local_counter = 0;
    if (place_meeting(x, y, oKris))   local_counter += 1;
    if (place_meeting(x, y, oRalsei)) local_counter += 1;
    if (place_meeting(x, y, oSusie))  local_counter += 1;

    // Añadimos al contador global
    global.counter_button_global += local_counter;

    // --- Animación individual ---
    if (local_counter == 0) {
        sprite_index = sButtonUnPressed;
        image_speed = 0.1;
    } 
    else if (local_counter >= 1) {
        sprite_index = sButtonPressed;
        image_speed = 0.1;

        // Mantener la animación hasta el último frame
        if (image_index < image_number - 1) {
            image_index += image_speed;
        } else {
            image_index = image_number - 1;
            image_speed = 0;
        }
    }

    // --- Explosión global ---
    if (global.counter_button_global >= 2) {
        sprite_index = sBoom;
        image_speed = 1;

        if (image_index < image_number - 1) {
            image_index += image_speed;
        } else {
            image_index = image_number - 1;
            image_speed = 0;
        }

        show_debug_message("💥 ¡BOOM GLOBAL! Dos o más personajes presionaron botones en modo comando.");
        global.explode = true;
        global.show_fail_window = true;
    }

    // Reiniciamos el contador global al final del Step
    global.counter_button_global = 0;
}
