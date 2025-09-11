///@description Step event 
/*
right_key= keyboard_check(vk_right);
left_key= keyboard_check(vk_left);
up_key= keyboard_check(vk_down); 
down_key= keyboard_check(vk_up); 

//Movement 
xspd = (right_key-left_key)* move_spd; 
yspd = (up_key - down_key) * move_spd; 


//Animate 

if xspd > 0{
	sprite_index = sKrisRight; 
} else if xspd < 0{
	sprite_index = sKrisLeft; 
} else if yspd > 0{
	sprite_index = sKrisDown; 
} else if yspd < 0{
	sprite_index = sKrisUp; 
}

if ( xspd != 0 or yspd != 0){
	image_speed = 1; 	
} else{
	image_speed= 0; 
	image_index = 0;
}
x += xspd; 
y += yspd; 


if ( global.keys_gray > 1) {
    global.sentado_gray = 0;
    movimiento_habilitado = true;
	sprite_index = sKrisDown;
	move_spd=1; 
}

if ( global.keys_golden > 0) {
    global.sentado_gold = 0;
    movimiento_habilitado = true;
	sprite_index = sKrisDown;
	move_spd=1; 
}

if (global.sentado_kris) {
    move_spd = 0;
	sprite_index = sKrisSat; 
}

if (instance_exists(oPlayButton)) if oPlayButton.playmode == false{ move_spd = 0}*/

/// @description Step event for Kris
// Step event
show_debug_message("Step running for " + my_name + ", current_action: " + string(current_action) + ", position: " + string(x) + ", " + string(y));

// Wait for commandmode to be initialized
if (waiting_for_commandmode) {
    if (variable_global_exists("commandmode")) {
        show_debug_message("Command mode initialized as: " + string(global.commandmode));
        if (global.commandmode) {
            speed = 0;
            target_x = x;
            target_y = y;
            current_action = noone;
            my_name = "Kris";
            xspd = 0;
            yspd = 0;
            move_spd = 1;
        } else {
            xspd = 0;
            yspd = 0;
            move_spd = 1;
            has_key = false;
            keys_golden = 0;
            keys_gray = 0;
            movimiento_habilitado = true;
        }
        waiting_for_commandmode = false;
    } else {
        show_debug_message("Waiting for commandmode to be initialized...");
        exit;
    }
}

// Command mode: Process commands if enabled
if (global.commandmode && !waiting_for_commandmode) {
    if (variable_global_exists("char_commands") && current_action == noone) {
        var cmd_list = global.char_commands[? my_name];
        show_debug_message("Command list for " + my_name + " exists: " + string(cmd_list != undefined));
        if (cmd_list != undefined && ds_list_size(cmd_list) > 0) {
            current_action = cmd_list[| 0];
            show_debug_message("New action for " + my_name + ": " + current_action.action + " " + current_action.target);
            if (current_action.action == "move_to") {
                handle_move_to(self, current_action); // Call the reusable function
            } else {
                show_debug_message("Unsupported action, resetting");
                current_action = noone;
            }
        }
    }
} else if (!waiting_for_commandmode) {
    // User movement mode
    var right_key = keyboard_check(vk_right);
    var left_key = keyboard_check(vk_left);
    var up_key = keyboard_check(vk_up); // Corrected from vk_down
    var down_key = keyboard_check(vk_down); // Corrected from vk_up

    // Movement
    xspd = (right_key - left_key) * move_spd;
    yspd = (down_key - up_key) * move_spd; // Adjusted for correct up/down logic

    // Animate
    if (xspd > 0) {
        sprite_index = sKrisRight;
    } else if (xspd < 0) {
        sprite_index = sKrisLeft;
    } else if (yspd > 0) {
        sprite_index = sKrisDown;
    } else if (yspd < 0) {
        sprite_index = sKrisUp;
    }

    if (xspd != 0 || yspd != 0) {
        image_speed = 1;
    } else {
        image_speed = 0;
        image_index = 0;
    }

    // Apply movement
    x += xspd;
    y += yspd;

    // Game state logic
    if (global.keys_gray > 1) {
        global.sentado_gray = 0;
        movimiento_habilitado = true;
        sprite_index = sKrisDown;
        move_spd = 1;
    }

    if (global.keys_golden > 0) {
        global.sentado_gold = 0;
        movimiento_habilitado = true;
        sprite_index = sKrisDown;
        move_spd = 1;
    }

    if (global.sentado_kris) {
        move_spd = 0;
        sprite_index = sKrisSat;
    }

	if (instance_exists(oPlayButton)) {
		move_spd = (oPlayButton.playmode) ? 1 : 0;
	}

    show_debug_message(my_name + " moved manually to: " + string(x) + ", " + string(y));
}

// Only move if an action is active and it's a move_to (command mode)
if (global.commandmode && !waiting_for_commandmode && current_action != noone && current_action.action == "move_to" && speed > 0) {
    var dist = point_distance(x, y, target_x, target_y);
    var tolerance = 50; // 🔥 margen para considerar "llegado"
    show_debug_message(my_name + " distance to target: " + string(dist) + ", from " + string(x) + ", " + string(y));

    if (dist > tolerance) {
        target_x = clamp(target_x, 0, room_width);
        target_y = clamp(target_y, 0, room_height);
        move_towards_point(target_x, target_y, speed);
        show_debug_message(my_name + " moving to " + string(target_x) + ", " + string(target_y));
    } else {
        // 🔥 Se considera que llegó
        x = target_x;
        y = target_y;

        with (obj_command_controller) {
            if (variable_global_exists("char_commands") && ds_map_exists(global.char_commands, other.my_name)) {
                var cmd_list = global.char_commands[? other.my_name];
                ds_list_delete(cmd_list, 0);
                if (ds_list_size(cmd_list) == 0) {
                    show_debug_message("No more commands for " + other.my_name);
                }
            }
        }

        current_action = noone;
        speed = 0;
        show_debug_message(my_name + " reached target at " + string(x) + ", " + string(y));
    }
}