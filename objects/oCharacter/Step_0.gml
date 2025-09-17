show_debug_message("Step running for " + my_name + ", current_action: " + string(current_action) + ", position: " + string(x) + ", " + string(y));

/// --- Inicialización ---
if (waiting_for_commandmode) {
    if (variable_global_exists("commandmode")) {
        show_debug_message("Command mode initialized: " + string(global.commandmode));
        if (global.commandmode) {
            speed = 0;
            target_x = x;
            target_y = y;
            current_action = noone;
            movimiento_habilitado = true;
        } else {
            xspd = 0; yspd = 0;
            move_spd = 1;
            has_key = false;
            keys_golden = 0;
            keys_gray = 0;
            movimiento_habilitado = true;
        }
        waiting_for_commandmode = false;
    } else {
        show_debug_message("Waiting for commandmode to initialize...");
        exit;
    }
}

/// --- COMMAND MODE ---
if (global.commandmode && !waiting_for_commandmode) {
    if (current_action == noone) {
        // Asegurarse de que el mapa existe
        if (!variable_global_exists("char_commands")) global.char_commands = ds_map_create();

        if (ds_map_exists(global.char_commands, my_name)) {
            var cmd_list = global.char_commands[? my_name];
            if (cmd_list != undefined && ds_list_size(cmd_list) > 0) {
                current_action = cmd_list[| 0];
                show_debug_message("Executing next action: " + current_action.action + " " + current_action.target);

                if (current_action.action == "move_to") {
                    handle_move_to(id, current_action);
                } else {
                    show_debug_message("Unsupported action, skipping");
                    current_action = noone;
                }
            }
        }
    }

    // Comprobar si terminó el path o está esperando
    if (current_action != noone && current_action.action == "move_to") {
        if (path_index == -1) { // Llegó al final del path
            show_debug_message(my_name + " reached target: " + current_action.target);
            
            // Verificar si está en un objeto P o V
            var target_obj = instance_place(x, y, oSemaphore);
            if (target_obj != noone) {
                if (target_obj.type == "P") {
                    if (global.semaphore_general > 0) {
                        global.semaphore_general -= 1;
                        show_debug_message(my_name + " performed P, semaphore = " + string(global.semaphore_general));
                        instance_create_layer(x, y, "Instances", oEffectTouch); // Efecto al tocar
                    } else {
                        show_debug_message(my_name + " waiting at P, semaphore = 0");
                        is_moving = true; // Mantener esperando
                        exit; // No continuar hasta que el semáforo esté disponible
                    }
                } else if (target_obj.type == "V") {
                    global.semaphore_general += 1;
                    show_debug_message(my_name + " performed V, semaphore = " + string(global.semaphore_general));
                    instance_create_layer(x, y, "Instances", oEffectTouch); // Efecto al tocar
                }
            }

            // Eliminar comando completado
            with (obj_command_controller) {
                if (variable_global_exists("char_commands") && ds_map_exists(global.char_commands, other.my_name)) {
                    var cmd_list = global.char_commands[? other.my_name];
                    if (ds_list_size(cmd_list) > 0) ds_list_delete(cmd_list, 0);
                }
            }
            current_action = noone;
            is_moving = false;
        }
    }
}

/// --- USER MOVEMENT MODE ---
// Este bloque se sobreescribirá en los hijos (Ralsei, Susie, Kris) con sus teclas y animaciones específicas