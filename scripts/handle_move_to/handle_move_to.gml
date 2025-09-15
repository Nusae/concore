function handle_move_to(character, current_action) {
    var target_obj = noone;
    var target_name = "o" + current_action.target; 
    var obj_index = asset_get_index(target_name);

    if (instance_exists(obj_index)) {
        target_obj = instance_nearest(character.x, character.y, obj_index);
    }

    if (target_obj != noone) {
        // Centro del sprite
        var tx = target_obj.x + (sprite_width/2 - sprite_xoffset);
        var ty = target_obj.y + (sprite_height/2 - sprite_yoffset);

        // Crear path evitando paredes
        var path = path_add();
        if (mp_grid_path(global.navgrid, path, character.x, character.y, tx, ty, true)) {
            path_start(path, 2, path_action_stop, false);
            show_debug_message(character.my_name + " following path to " + string(tx) + ", " + string(ty));
        } else {
            show_debug_message("⚠️ No path found to target: " + string(current_action.target));
            current_action = noone;
            path_delete(path);
        }
    } else {
        show_debug_message("No target found: " + target_name);
        current_action = noone;
    }
}
