/// @description Step event for Susie
show_debug_message("Step running for Susie, current_action: " + string(current_action) + ", position: " + string(x) + ", " + string(y));

// --- Initialization ---
if (waiting_for_commandmode) {
    if (variable_global_exists("commandmode")) {
        show_debug_message("Command mode initialized: " + string(global.commandmode));
        if (global.commandmode) {
            speed = 0;
            target_x = x;
            target_y = y;
            current_action = noone;
            my_name = "Susie";
            xspd = 0;
            yspd = 0;
            move_spd = 1;
            has_key = false;
            keys_gray = 0;
            keys_golden = 0;
            movimiento_habilitado = true;
        } else {
            xspd = 0;
            yspd = 0;
            move_spd = 1;
            has_key = false;
            keys_gray = 0;
            keys_golden = 0;
            movimiento_habilitado = true;
        }
        waiting_for_commandmode = false;
    } else {
        show_debug_message("Waiting for commandmode to initialize...");
        exit;
    }
}

// --- Command Mode ---
if (global.commandmode && !waiting_for_commandmode) {
    if (current_action == noone) {
        // Ensure the command map exists
        if (!variable_global_exists("char_commands")) global.char_commands = ds_map_create();

        if (ds_map_exists(global.char_commands, my_name)) {
            var cmd_list = global.char_commands[? my_name];
            if (cmd_list != undefined && ds_list_size(cmd_list) > 0) {
                current_action = cmd_list[| 0];
                show_debug_message("Executing next action: " + current_action.action + " " + string(current_action.target));

                if (current_action.action == "move_to") {
                    handle_move_to(self, current_action);
                } else {
                    show_debug_message("Unsupported action, skipping");
                    current_action = noone;
                }
            }
        }
    }

    // Check if the path is complete
    if (current_action != noone && current_action.action == "move_to") {
        if (path_index == -1) { // Reached the end of the path
            show_debug_message(my_name + " reached target: " + string(current_action.target));
            
            // Remove completed command
            with (obj_command_controller) {
                if (variable_global_exists("char_commands") && ds_map_exists(global.char_commands, other.my_name)) {
                    var cmd_list = global.char_commands[? other.my_name];
                    if (ds_list_size(cmd_list) > 0) ds_list_delete(cmd_list, 0);
                }
            }

            current_action = noone;
        }
    }
}

// --- User Movement Mode ---
else if (!waiting_for_commandmode) {
    var right_key = keyboard_check(ord("K"));
    var left_key = keyboard_check(ord("H"));
    var up_key = 0; // keyboard_check(ord("U"));
    var down_key = keyboard_check(ord("J"));

    if (!variable_instance_exists(id, "move_spd")) move_spd = 1;
    xspd = (right_key - left_key) * move_spd;
    yspd = (down_key - up_key) * move_spd;

    // Animation
    if (xspd > 0) sprite_index = sSusieRight;
    else if (xspd < 0) sprite_index = sSusieLeft;
    else if (yspd > 0) sprite_index = sSusieDown;
    else if (yspd < 0) sprite_index = sSusieUp;

    if (xspd != 0 || yspd != 0) image_speed = 1;
    else { image_speed = 0; image_index = 0; }

    // Apply movement
    if (movimiento_habilitado) {
        x += xspd;
        y += yspd;
    }

    // Game state logic
    if (keys_gray > 1) {
        global.sentado_gray = 0;
        movimiento_habilitado = true;
        sprite_index = sSusieDown;
        move_spd = 1;
    }
    if (keys_golden > 0) {
        global.sentado_gold = 0;
        movimiento_habilitado = true;
        sprite_index = sSusieDown;
        move_spd = 1;
    }
    if (global.sentado_susie) {
        move_spd = 0;
        sprite_index = sSusieSat;
    }
    if (instance_exists(oPlayButton)) move_spd = (oPlayButton.playmode) ? 1 : 0;

    if (xspd != 0 || yspd != 0) {
        show_debug_message("Susie moved manually to: " + string(x) + ", " + string(y));
    }
}