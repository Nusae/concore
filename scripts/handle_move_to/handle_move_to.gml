function handle_move_to(character, current_action) {
    // Obtener el índice del objeto objetivo
    var target_name = "o" + current_action.target;
    var obj_index = asset_get_index(target_name);

    if (!object_exists(obj_index)) {
        show_debug_message("No se encontró objeto con nombre: " + target_name);
        current_action = noone;
        exit;
    }

    // Actualizar el grid de navegación
    mp_grid_clear_all(global.navgrid);
    with (oWall) {
        mp_grid_add_instances(global.navgrid, id, false);
    }

    // Buscar el objeto válido más cercano
    var target_obj = instance_nearest(character.x, character.y, obj_index);
    var tries = 0;
    var max_tries = instance_number(obj_index);

    while (target_obj != noone && target_obj.y < character.y && tries < max_tries) {
        show_debug_message("❌ " + character.my_name + " encontró target más arriba (" + string(target_obj.y) + "), buscando otro...");
        with (target_obj) {
            already_checked = true;
        }

        // Buscar siguiente candidato
        target_obj = noone;
        var dist = 999999;
        with (obj_index) {
            if (!variable_instance_exists(id, "already_checked")) {
                var d = point_distance(character.x, character.y, x, y);
                if (d < dist) {
                    dist = d;
                    target_obj = id;
                }
            }
        }
        tries++;
    }

    // Si no hay objetivos válidos
    if (target_obj == noone) {
        show_debug_message("⚠️ No hay targets válidos hacia abajo para " + character.my_name);
        current_action = noone;
        with (obj_index) {
            if (variable_instance_exists(id, "already_checked")) {
                already_checked = false;
            }
        }
        exit;
    }

    // Calcular el centro del objetivo (alineado al grid de 32x32)
    var tx = floor(target_obj.x / 32) * 32 + 16;
    var ty = floor(target_obj.y / 32) * 32 + 16;

    // Intentar encontrar un camino válido
    var path = path_add();
    var path_found = false;
    var path_tries = 0;
    var max_path_tries = 5;
    var cell_size = 32;

    // Puntos alternativos (centro, izquierda, derecha, arriba, abajo)
    var offsets = [
        [0, 0],          // Centro
        [-cell_size, 0], // Izquierda
        [cell_size, 0],  // Derecha
        [0, -cell_size], // Arriba
        [0, cell_size]   // Abajo
    ];

    while (!path_found && path_tries < max_path_tries) {
        // Calcular punto de prueba
        var offset = offsets[path_tries];
        var test_tx = tx + offset[0];
        var test_ty = ty + offset[1];

        // Alinear al grid
        test_tx = floor(test_tx / 32) * 32 + 16;
        test_ty = floor(test_ty / 32) * 32 + 16;

        // Verificar si el punto está libre
        if (!collision_point(test_tx, test_ty, oWall, true, true)) {
            if (mp_grid_path(global.navgrid, path, character.x, character.y, test_tx, test_ty, true)) {
                // Asegurarse de que el personaje esté alineado al inicio del camino
                var start_x = floor(character.x / 32) * 32 + 16;
                var start_y = floor(character.y / 32) * 32 + 16;
                if (mp_grid_path(global.navgrid, path, start_x, start_y, test_tx, test_ty, true)) {
                    path_start(path, 2, path_action_stop, false);
                    show_debug_message(character.my_name + " siguiendo path a (" + string(test_tx) + ", " + string(test_ty) + ")");
                    path_found = true;
                } else {
                    show_debug_message("⚠️ Camino desde (" + string(start_x) + ", " + string(start_y) + ") falló");
                }
            } else {
                show_debug_message("⚠️ Camino a (" + string(test_tx) + ", " + string(test_ty) + ") falló");
            }
        } else {
            show_debug_message("⚠️ Punto (" + string(test_tx) + ", " + string(test_ty) + ") está bloqueado por oWall");
        }
        path_tries++;
    }

    // Si no se encontró un camino
    if (!path_found) {
        show_debug_message("⚠️ No se pudo encontrar un camino válido para " + character.my_name);
        current_action = noone;
        path_delete(path);
        with (obj_index) {
            if (variable_instance_exists(id, "already_checked")) {
                already_checked = false;
            }
        }
        show_debug_message("🔍 Buscando otro objetivo en el próximo ciclo...");
    }
}