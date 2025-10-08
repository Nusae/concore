
// Crear grid global de navegación basado en celdas de 32x32
var gw = ceil(room_width / 32);
var gh = ceil(room_height / 32);
global.navgrid = mp_grid_create(0, 0, gw, gh, 32, 32);

// Añadir paredes al grid (solo una vez)
mp_grid_add_instances(global.navgrid, oWall, false);

show_debug_message("✅ Grid creado: " + string(gw) + "x" + string(gh));
