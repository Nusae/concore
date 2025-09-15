
var gw = room_width div 32;  
var gh = room_height div 32;  
global.navgrid = mp_grid_create(0, 0, gw, gh, 32, 32);

// Marcar las celdas bloqueadas (ej: todas las paredes)
mp_grid_add_instances(global.navgrid, oWall, false);
