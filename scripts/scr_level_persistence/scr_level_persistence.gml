/// @function save_level(filename_base)
/// @description Serializes the current room state into a JSON file.
function save_level(filename_base) {
    if (filename_base == "") filename_base = "save_" + string(current_day) + "_" + string(current_month) + "_" + string(current_hour) + "_" + string(current_minute);
    var save_path = working_directory + filename_base + ".json";
    
    var data = capture_level_data();
    
    // Serialize and save
    var json = json_stringify(data);
    var buffer = buffer_create(string_byte_length(json) + 1, buffer_fixed, 1);
    buffer_write(buffer, buffer_string, json);
    buffer_save(buffer, save_path);
    buffer_delete(buffer);
    
    show_debug_message("💾 Nivel guardado en: " + save_path);
}

/// @function load_level(filename_base)
/// @description Deserializes a room state from a JSON file.
function load_level(filename_base) {
    var load_path = working_directory + filename_base + ".json";
    if (!file_exists(load_path)) {
        show_debug_message("❌ Error: No se encontró el archivo " + load_path);
        return false;
    }
    
    // Read and parse JSON
    var buffer = buffer_load(load_path);
    var json = buffer_read(buffer, buffer_string);
    buffer_delete(buffer);
    var data = json_parse(json);
    
    apply_level_data(data);
    
    show_debug_message("📂 Nivel cargado exitosamente");
    return true;
}

/// @function capture_level_data()
/// @description Returns a struct with all level info.
function capture_level_data() {
    var data = {
        objects: [],
        commands: { ralsei: [], kris: [], susie: [] },
        globals: { keys_gray: global.keys_gray, keys_golden: global.keys_golden }
    };
    
    var objects_to_save = [oWall, oKris, oSusie, oRalsei, oGrayD, oGoldD, oGrayS, oGoldS, oSwitch, oButton, oTable, oPC, oPoster, oLavaLamp, oChair, oBed, oMeta];
    for (var i = 0; i < array_length(objects_to_save); i++) {
        var obj_type = objects_to_save[i];
        with (obj_type) {
            array_push(data.objects, { obj: object_get_name(object_index), x: x, y: y });
        }
    }
    
    if (instance_exists(obj_command_editor_draw_gui)) {
        data.commands.ralsei = obj_command_editor_draw_gui.commands_ralsei;
        data.commands.kris   = obj_command_editor_draw_gui.commands_kris;
        data.commands.susie  = obj_command_editor_draw_gui.commands_susie;
    }
    return data;
}

/// @function apply_level_data(data)
/// @description Restores everything from a struct.
function apply_level_data(data) {
    var objects_to_clear = [oWall, oKris, oSusie, oRalsei, oGrayD, oGoldD, oGrayS, oGoldS, oSwitch, oButton, oTable, oPC, oPoster, oLavaLamp, oChair, oBed, oMeta];
    for (var i = 0; i < array_length(objects_to_clear); i++) {
        instance_destroy(objects_to_clear[i]);
    }
    
    for (var i = 0; i < array_length(data.objects); i++) {
        var item = data.objects[i];
        var obj_index = asset_get_index(item.obj);
        if (obj_index != -1) {
            instance_create_layer(item.x, item.y, "Instances", obj_index);
        }
    }
    
    if (instance_exists(obj_command_editor_draw_gui)) {
        obj_command_editor_draw_gui.commands_ralsei = data.commands.ralsei;
        obj_command_editor_draw_gui.commands_kris   = data.commands.kris;
        obj_command_editor_draw_gui.commands_susie  = data.commands.susie;
    }
    
    global.keys_gray = data.globals.keys_gray;
    global.keys_golden = data.globals.keys_golden;
    
    if (instance_exists(obj_Pathfinder)) {
        with (obj_Pathfinder) {
            mp_grid_clear_all(global.navgrid);
            mp_grid_add_instances(global.navgrid, oWall, false);
        }
    }
}

/// @function export_level_to_clipboard()
function export_level_to_clipboard() {
    var data = capture_level_data();
    var json = json_stringify(data);
    clipboard_set_text(json);
    show_debug_message("📋 Código de nivel copiado al portapapeles");
}

/// @function import_level_from_clipboard()
function import_level_from_clipboard() {
    var json = clipboard_get_text();
    try {
        var data = json_parse(json);
        if (variable_struct_exists(data, "objects")) {
            apply_level_data(data);
            show_debug_message("📋 Nivel pegado desde el portapapeles");
            return true;
        }
    } catch (_e) {
        show_debug_message("❌ Error: Portapapeles no contiene un nivel válido");
    }
    return false;
}
