/// @description Navegación de la galería
if (keyboard_check_pressed(vk_up)) {
    selected_index = (selected_index - 1 + array_length(levels)) % max(1, array_length(levels));
}
if (keyboard_check_pressed(vk_down)) {
    selected_index = (selected_index + 1) % max(1, array_length(levels));
}

if (keyboard_check_pressed(vk_enter) && array_length(levels) > 0) {
    load_level(levels[selected_index]);
    instance_destroy();
}

if (keyboard_check_pressed(vk_escape)) {
    instance_destroy();
}

// Borrar nivel con la tecla Suprimir
if (keyboard_check_pressed(vk_delete) && array_length(levels) > 0) {
    var _file = working_directory + levels[selected_index] + ".json";
    if (file_exists(_file)) {
        file_delete(_file);
        array_delete(levels, selected_index, 1);
        selected_index = max(0, min(selected_index, array_length(levels) - 1));
    }
}
