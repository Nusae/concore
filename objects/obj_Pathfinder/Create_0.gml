// En el evento Create de un objeto controlador (ej: obj_controller)
// Asegurarse de que se ejecute después de que las instancias de oWall estén creadas
var gw = ceil(room_width / 32); // Usar ceil para incluir celdas parciales
var gh = ceil(room_height / 32);
global.navgrid = mp_grid_create(0, 0, gw, gh, 32, 32);

// Marcar las celdas bloqueadas por oWall
with (oWall) {
    mp_grid_add_instances(global.navgrid, id, false);
}