/// @description 

/*
xspd = 0; 
yspd = 0; 

move_spd = 1;

has_key = false;
keys_golden = 0;
keys_gray = 0;
movimiento_habilitado = true;*/

// Safe check for commandmode (optional, remove if not needed)
/*if (variable_global_exists("commandmode")) {
    show_debug_message("Command mode initialized as: " + string(global.commandmode));
} else {
    show_debug_message("Command mode not yet initialized, defaulting to false");
    global.commandmode = true; // Fallback, though Game Start should handle this
}

if(global.commandmode){
speed = 0; // Start with no movement
x = 100; // Set a different starting x
y = 100; // Set a different starting y
target_x = x;
target_y = y;
current_action = noone;
my_name = "Ralsei";
} else{
xspd = 0; 
yspd = 0; 

move_spd = 1;

has_key = false;
keys_golden = 0;
keys_gray = 0;
movimiento_habilitado = true;	
}*/

/// @description Initialize Ralsei variables with delayed mode setup
waiting_for_commandmode = true; // Flag to wait for commandmode initialization
show_debug_message("Ralsei waiting for commandmode initialization...");
my_name = "Ralsei";
current_action = noone; 
depth = -100;