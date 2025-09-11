// Reiniciar variables globales
global.keys_golden = 1;
global.keys_gray = 2;
global.sentado_susie = 0;
global.sentado_kris = 0;
global.sentado_ralsei = 0;
/// @description Level 4 setup
global.commandmode = true; // Or false, depending on your level design
show_debug_message("oGameLv4 set commandmode to: " + string(global.commandmode));

sprite_index = sWall; // Esto puede quitarse si no es una instancia visible
personaje = 3;

// ⚠️ IMPORTANTE: crear las instancias del editor
if (is_array(global.level_data)) {
    for (var i = 0; i < array_length(global.level_data); i++) {
        var data = global.level_data[i];
        instance_create_layer(data.x, data.y, "Instances", data.obj);
    }
}

