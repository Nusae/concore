//--------------
// STEP EVENT - BASE CHARACTER
//-------------------------

//--------------
// INICIALIZACIÓN
//-------------------------
if (waiting_for_commandmode) {
    if (variable_global_exists("commandmode")) {
        if (global.commandmode) {
            speed = 0;
            target_x = x;
            target_y = y;
            current_action = noone;
        }
        waiting_for_commandmode = false;
    } else {
        exit;
    }
}

//--------------
// MODO COMANDO
//-------------------------
if (global.commandmode && !waiting_for_commandmode) {
    if (current_action == noone) {
        if (!variable_global_exists("char_commands")) global.char_commands = ds_map_create();

        if (ds_map_exists(global.char_commands, my_name)) {
            var cmd_list = global.char_commands[? my_name];
            if (cmd_list != undefined && ds_list_size(cmd_list) > 0) {
                current_action = cmd_list[| 0];
                show_debug_message(my_name + " executing next action: " + current_action.action + " " + current_action.target);

                if (current_action.action == "move_to") {
                    handle_move_to(self, current_action);
                } else if (current_action.action == "delay") {
                    // Delay se maneja en el siguiente bloque
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
                    if (variable_struct_exists(current_action, "target_instance") 
                        && nearby == current_action.target_instance 
                        && dist_blocks < 1) {
                        // Ya en el target
                    }
                    else if (dist_blocks <= 60 && (!variable_struct_exists(current_action, "target_instance") 
                           || nearby != current_action.target_instance)) {
                        path_end();
                        current_action.target_instance = nearby.id;
                        handle_move_to(self, current_action);
                    }
                }
            }
            
            // Finalizar acción si llegó al destino
            if (path_index == -1) {
                show_debug_message(my_name + " reached target: " + string(current_action.target));
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
                with (obj_command_controller) {
                    if (variable_global_exists("char_commands") && ds_map_exists(global.char_commands, other.my_name)) {
                        var cmd_list = global.char_commands[? other.my_name];
                        if (ds_list_size(cmd_list) > 0) ds_list_delete(cmd_list, 0);
                    }
                }
            }
        }
    }
    
    // Animación por defecto en comando
    if (movimiento_habilitado && spr_down != -1) { sprite_index = spr_down; }
}

//--------------
// MODO MOVIMIENTO MANUAL
//-------------------------
else if (!waiting_for_commandmode) {
    var r_key = (key_right != -1) ? keyboard_check(key_right) : 0;
    var l_key = (key_left != -1) ? keyboard_check(key_left) : 0;
    var u_key = (key_up != -1) ? keyboard_check(key_up) : 0;
    var d_key = (key_down != -1) ? keyboard_check(key_down) : 0;
    
    var current_room = room_get_name(room);
    if (current_room != "Start" && current_room != "Logic" && current_room != "Editorlv") {
        u_key = 0;
    }

    xspd = (r_key - l_key) * move_spd;
    yspd = (d_key - u_key) * move_spd;

    // Animación
    if (xspd > 0 && spr_right != -1) sprite_index = spr_right;
    else if (xspd < 0 && spr_left != -1) sprite_index = spr_left;
    else if (yspd > 0 && spr_down != -1) sprite_index = spr_down;
    else if (yspd < 0 && spr_up != -1) sprite_index = spr_up;

    if (xspd != 0 || yspd != 0) image_speed = 1;
    else { image_speed = 0; image_index = 0; }

    // Aplicar movimiento si no está bloqueado
    if (movimiento_habilitado && !global.movimiento_bloqueado && !is_blocked_specific) {
        x += xspd;
        y += yspd;
    }


    if (instance_exists(oPlayButton)) move_spd = (oPlayButton.playmode) ? 1 : 0;
}