// Variables comunes (se pueden sobreescribir en el Create del niño)
my_name = "Unknown";
move_spd = 1;
target_x = x;
target_y = y;
xspd = 0;
yspd = 0;

// Variables de estado
waiting_for_commandmode = true;
current_action = noone;
movimiento_habilitado = true;
path = path_add();
is_moving = false;

// Sprites por defecto (deben definirse en el Create del niño)
spr_up = -1;
spr_down = -1;
spr_left = -1;
spr_right = -1;

// Teclas por defecto (deben definirse en el Create del niño)
key_up = -1;
key_down = -1;
key_left = -1;
key_right = -1;

// Inicialización de seguridad para variables globales
if (!variable_global_exists("movimiento_bloqueado")) global.movimiento_bloqueado = false;
depth = -100;
is_blocked_specific = false; // Se puede vincular a global.kris_bloqueado en el hijo
