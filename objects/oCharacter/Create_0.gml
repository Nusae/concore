// Variables comunes
my_name = "Unknown"; // Se define en el Create de cada personaje (Ralsei, Susie, Kris)
move_spd = 2;       // Velocidad de movimiento
target_x = x;       // Posición objetivo X (fija por columna)
target_y = y;       // Posición objetivo Y
column = 0;         // Columna asignada (definir en Create: 0 para Ralsei, 1 para Susie, 2 para Kris)
waiting_for_commandmode = true;
current_action = noone;
movimiento_habilitado = true;
path = path_add();  // Path para movimiento
is_moving = false;