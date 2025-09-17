function handle_move_to(character, current_action) {
    var target_name = "o" + current_action.target; 
    var obj_index = asset_get_index(target_name);

    if (!object_exists(obj_index)) {
        show_debug_message("No se encontró objeto con nombre: " + target_name);
        current_action = noone;
        exit;
    }

    // Buscar el objeto válido más cercano
    var target_obj = instance_nearest(character.x, character.y, obj_index);
    var tries = 0;

    while (target_obj != noone && target_obj.y < character.y && tries < instance_number(obj_index)) {
        show_debug_message("❌ " + character.my_name + " encontró target más arriba (" + string(target_obj.y) + "), buscando otro...");
        // Ignorar esta instancia y buscar la siguiente más cercana
        with (target_obj) {
            // Marcamos con una variable temporal para no volver a elegirlo
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

    // Si no encontró ninguno válido
    if (target_obj == noone) {
        show_debug_message("⚠️ No hay targets válidos hacia abajo para " + character.my_name);
        current_action = noone;
        exit;
    }

    // Centro del sprite destino
    var tx = target_obj.x + (sprite_width/2 - sprite_xoffset);
    var ty = target_obj.y + (sprite_height/2 - sprite_yoffset);

    // Crear path evitando paredes
    var path = path_add();
    if (mp_grid_path(global.navgrid, path, character.x, character.y, tx, ty, true)) {
        path_start(path, 2, path_action_stop, false);
        show_debug_message(character.my_name + " siguiendo path a " + string(tx) + ", " + string(ty));
    } else {
        show_debug_message("⚠️ No se encontró path a: " + string(current_action.target));
        current_action = noone;
        path_delete(path);
    }

}

