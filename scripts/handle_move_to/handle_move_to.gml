/// handle_move_to(character, current_action)
/// Hace que el personaje siga un camino hacia el target indicado en current_action.target

function handle_move_to(character, current_action) {

    // 1️⃣ Verificar grid
    if (!variable_global_exists("navgrid") || global.navgrid == noone) {
        show_debug_message("🚫 " + character.my_name + ": global.navgrid no existe");
        exit;
    }

    // 2️⃣ Alinear al grid (importante para evitar muros)
    character.x = floor(character.x / 32) * 32 + 16;
    character.y = floor(character.y / 32) * 32 + 16;

    // 3️⃣ Buscar objeto objetivo
    var target_name = "o" + current_action.target;
    var obj_index = asset_get_index(target_name);

    if (!object_exists(obj_index)) {
        show_debug_message("❌ " + character.my_name + ": No se encontró " + target_name);
        exit;
    }

    var target_obj = instance_nearest(character.x, character.y, obj_index);

    if (target_obj == noone) {
        show_debug_message("⚠️ " + character.my_name + ": No hay instancias de " + target_name);
        exit;
    }

    // 4️⃣ Calcular posiciones alineadas al grid
    var start_x = floor(character.x / 32) * 32 + 16;
    var start_y = floor(character.y / 32) * 32 + 16;
    var tx = floor(target_obj.x / 32) * 32 + 16;
    var ty = floor(target_obj.y / 32) * 32 + 16;

    // 5️⃣ Crear path temporal
    var path = path_add();
    var found = mp_grid_path(global.navgrid, path, start_x, start_y, tx, ty, true);

    if (found) {
        show_debug_message("✅ " + character.my_name + ": Path encontrado hacia (" + string(tx) + ", " + string(ty) + ")");
        path_start(path, 2, path_action_stop, false);
    } else {
        show_debug_message("🚫 " + character.my_name + ": No se pudo encontrar camino a (" + string(tx) + ", " + string(ty) + ")");
        path_delete(path);
    }
}
