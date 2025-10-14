
//--------------
// STEP EVENT - RALSEI
//-------------------------
// Depuración inicial
show_debug_message("Step running for Ralsei, current_action: " + string(current_action) + ", position: " + string(x) + ", " + string(y));

//--------------
// INICIALIZACIÓN
//-------------------------
if (waiting_for_commandmode) {
    if (variable_global_exists("commandmode")) {
        show_debug_message("Command mode initialized: " + string(global.commandmode));
        if (global.commandmode) {
            speed = 0;
            target_x = x;
            target_y = y;
            current_action = noone;
        }
        waiting_for_commandmode = false;
    } else {
        show_debug_message("Waiting for commandmode to initialize...");
        exit;
    }
}

//--------------
// MODO COMANDO
//-------------------------
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
                    handle_move_to(self, current_action);
                } else if (current_action.action == "delay") {
                    // Delay se maneja en el siguiente bloque; no eliminar aún
                } else {
                    show_debug_message("Unsupported action, skipping");
                    current_action = noone;
                }
            }
        }
    }

    // Manejar acciones en curso
    if (current_action != noone) {
        if (current_action.action == "move_to") {
            // Verificación dinámica de targets
            var target_index = asset_get_index("o" + current_action.target);
            if (object_exists(target_index)) {
                var nearby = instance_nearest(x, y, target_index);
                if (nearby != noone) {
                    var dist_blocks = point_distance(x, y, nearby.x, nearby.y) / 32;
                    // Si ya estoy en el target → no hago nada
                    if (variable_struct_exists(current_action, "target_instance") 
                        && nearby == current_action.target_instance 
                        && dist_blocks < 1) {
                        show_debug_message(my_name + " ya está encima del target, no se hace nada.");
                    }
                    // Si hay otro target válido más cercano → redirigir
                    else if (dist_blocks <= 60 && (!variable_struct_exists(current_action, "target_instance") 
                           || nearby != current_action.target_instance)) {
                        show_debug_message(my_name + " redirigiendo a un target más cercano (" 
                                           + string(nearby.x) + ", " + string(nearby.y) + ")");
                        path_end();
                        current_action.target_instance = nearby.id;
                        handle_move_to(self, current_action);
                    }
                }
            }
            
            // Finalizar acción si llegó al destino
            if (path_index == -1) {
                show_debug_message(my_name + " reached target: " + string(current_action.target));
                
                // Eliminar comando completado de la lista
                with (obj_command_controller) {
                    if (variable_global_exists("char_commands") && ds_map_exists(global.char_commands, other.my_name)) {
                        var cmd_list = global.char_commands[? other.my_name];
                        if (ds_list_size(cmd_list) > 0) ds_list_delete(cmd_list, 0);
                    }
                }
                current_action = noone;
            }
        } else if (current_action.action == "delay") {
            current_action = handle_delay(self, current_action);
            if (current_action == noone) {
                // Delay completado, eliminar de la lista de comandos
                with (obj_command_controller) {
                    if (variable_global_exists("char_commands") && ds_map_exists(global.char_commands, other.my_name)) {
                        var cmd_list = global.char_commands[? other.my_name];
                        if (ds_list_size(cmd_list) > 0) ds_list_delete(cmd_list, 0);
                    }
                }
            }
        }
    }
    
    // Actualizar sprite si el movimiento está habilitado
    if (movimiento_habilitado) { sprite_index = sRalseiDown }
}

//--------------
// MODO MOVIMIENTO MANUAL
//-------------------------
else if (!waiting_for_commandmode) {
    var right_key = keyboard_check(ord("D"));
    var left_key = keyboard_check(ord("A"));
    var up_key = keyboard_check(ord("W"));
    var down_key = keyboard_check(ord("S"));

    var current_room = room_get_name(room);
    // Desactivar movimiento hacia arriba en salas que no sean Start, Logic ni Editorlv
    if (current_room != "Start" && current_room != "Logic" && current_room != "Editorlv") {
        up_key = 0;
    }

    if (!variable_instance_exists(id, "move_spd")) move_spd = 1;
    xspd = (right_key - left_key) * move_spd;
    yspd = (down_key - up_key) * move_spd;

    // Animación
    if (xspd > 0) sprite_index = sRalseiRight;
    else if (xspd < 0) sprite_index = sRalseiLeft;
    else if (yspd > 0) sprite_index = sRalseiDown;
    else if (yspd < 0) sprite_index = sRalseiUp;

    if (xspd != 0 || yspd != 0) image_speed = 1;
    else { image_speed = 0; image_index = 0; }

    // Aplicar movimiento
    x += xspd;
    y += yspd;

    if (instance_exists(oPlayButton)) {
        move_spd = oPlayButton.playmode ? 1 : 0;
    }

    show_debug_message("Ralsei moved manually to: " + string(x) + ", " + string(y));
}

//--------------
// LÓGICA DE ESTADO
//-------------------------
if (global.sentado_ralsei) {
    move_spd = 0;
    sprite_index = sRalseiSat1;
} else {
    move_spd = 1;
}

if (global.keys_gray > 0) {
    global.sentado_ralsei = false;
    global.sentado_gray = 0;
    movimiento_habilitado = true;
    move_spd = 1;
}
if (global.keys_golden > 0) {
    global.sentado_ralsei = false;
    global.sentado_gold = 0;
    movimiento_habilitado = true;
    move_spd = 1;
}


if( global.ralsei_cama == true) {
	visible = false; 
}
