// oEditor: Step Event

var mx = mouse_x div grid_size * grid_size;
var my = mouse_y div grid_size * grid_size;

// Colocar objeto con clic
if (mouse_check_button_pressed(mb_left)) {
    var obj = menu_items[selected_index].obj;

    // Si es Kris y ya existe uno, no colocar
    if (obj == oKris && instance_exists(oKris)) exit;

    // Si es Susie y ya existe uno, no colocar
    if (obj == oSusie && instance_exists(oSusie)) exit;

    // Si es Ralsei y ya existe uno, no colocar
    if (obj == oRalsei && instance_exists(oRalsei)) exit;

    // Colocar objeto
    instance_create_layer(mx, my, "Instances", obj);
}


// Cambiar selección con teclas (flechas)
if (keyboard_check_pressed(ord("5"))) {
    selected_index = (selected_index + 1) mod array_length(menu_items);
}
if (keyboard_check_pressed(ord("6"))) {
    selected_index = (selected_index - 1 + array_length(menu_items)) mod array_length(menu_items);
}

// Ajustar llaves con teclas
if (keyboard_check_pressed(ord("1"))) global.keys_gray++;
if (keyboard_check_pressed(ord("2"))) global.keys_gray--;

if (keyboard_check_pressed(ord("3"))) global.keys_golden++;
if (keyboard_check_pressed(ord("4"))) global.keys_golden--;


if (keyboard_check_pressed(ord("8"))) {
    global.show_fail_window = false;
    global.explode = false;
    room_restart(); 
}

// --- Guardado y Carga de Niveles ---
if (keyboard_check_pressed(ord("S"))) {
    save_level("level_editor_1");
}

if (keyboard_check_pressed(ord("L"))) {
    load_level("level_editor_1");
}

// --- Galería y Compartir ---
if (keyboard_check_pressed(ord("G"))) {
    if (!instance_exists(obj_level_gallery)) {
        instance_create_layer(0, 0, "Instances", obj_level_gallery);
    }
}

if (keyboard_check_pressed(ord("C"))) {
    export_level_to_clipboard();
}

if (keyboard_check_pressed(ord("V"))) {
    import_level_from_clipboard();
}

if (keyboard_check_pressed(ord("N"))) {
    save_level(""); // Genera un nombre automático con fecha/hora
}
