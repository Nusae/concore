waiting_for_commandmode = true; // Flag to wait for commandmode initialization
show_debug_message("Ralsei waiting for commandmode initialization...");
my_name = "Ralsei";
current_action = noone; 
depth = -100;
movimiento_habilitado = true;

xspd = 0;
yspd = 0;
move_spd = 1;

global.ralsei_cama = false; 

// Inicialización de seguridad para variables globales
if (!variable_global_exists("movimiento_bloqueado")) global.movimiento_bloqueado = false;
if (!variable_global_exists("kris_bloqueado")) global.kris_bloqueado = false;