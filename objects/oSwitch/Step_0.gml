/// --- SWITCH STEP EVENT ---

// Inicializamos variables si no existen
if (!variable_instance_exists(id, "completed")) completed = false;
if (!variable_instance_exists(id, "pressed")) pressed = false;
if (!variable_instance_exists(id, "timer")) timer = 0;
if (!variable_instance_exists(id, "counter_switch_local")) counter_switch_local = 0;

// ===============================
// MODO NORMAL (cada switch independiente)
// ===============================
if (!global.commandmode) {
    if (!completed) {
        counter_switch_local = 0;

        if (place_meeting(x, y, oKris))   counter_switch_local += 1;
        if (place_meeting(x, y, oRalsei)) counter_switch_local += 1;
        if (place_meeting(x, y, oSusie))  counter_switch_local += 1;

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
    }
    else {
        sprite_index = sSwitchPressed;
        image_index = image_number - 1;
        image_speed = 0;
    }
}
else {
    // ===============================
    // MODO COMMAND: explosión si TODOS los personajes están en switches
    // ===============================

    // Cada switch sigue funcionando de forma independiente
    if (!completed) {
        counter_switch_local = 0;

        if (place_meeting(x, y, oKris))   counter_switch_local += 1;
        if (place_meeting(x, y, oRalsei)) counter_switch_local += 1;
        if (place_meeting(x, y, oSusie))  counter_switch_local += 1;

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
    }
    else {
        sprite_index = sSwitchPressed;
        image_index = image_number - 1;
        image_speed = 0;
    }

    // ===============================
    // DETECCIÓN GLOBAL DE EXPLOSIÓN
    // ===============================

    // Ver cuántos personajes están sobre algún switch
    var switches_total = instance_number(oSwitch); // <-- pon aquí el nombre real del objeto switch
    var personajes_en_switch = 0;

    // Recorre todos los switches y cuenta cuántos personajes hay encima en total
    with (oSwitch) { // reemplaza oSwitch si tu objeto se llama distinto
        if (place_meeting(x, y, oKris))   personajes_en_switch += 1;
        if (place_meeting(x, y, oRalsei)) personajes_en_switch += 1;
        if (place_meeting(x, y, oSusie))  personajes_en_switch += 1;
    }

    // Si los tres personajes están sobre switches → explosión global
    if (personajes_en_switch >= 3) {
        show_debug_message("¡BOOM GLOBAL! Los tres personajes están sobre switches.");
        global.explode = true;
        global.show_fail_window = true;

        // Todos los switches cambian a sprite de explosión
        with (oSwitch) {
            sprite_index = sBoom;
            image_speed = 1;
            if (image_index >= image_number - 1) {
                image_index = image_number - 1;
                image_speed = 0;
            }
        }
    }
}


