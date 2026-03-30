/// @description Iniciar galería
levels = [];
selected_index = 0;

// Buscar archivos JSON en el directorio de trabajo
var _file = file_find_first(working_directory + "*.json", 0);
while (_file != "") {
    array_push(levels, filename_change_ext(_file, ""));
    _file = file_find_next();
}
file_find_close();

if (array_length(levels) == 0) {
    show_debug_message("No se encontraron niveles guardados.");
}
