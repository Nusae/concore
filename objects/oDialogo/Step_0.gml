if (!finished) {
    dialog_timer += 1;
    if (dialog_timer >= dialog_speed && dialog_pos < string_length(dialog_full)) {
        dialog_pos += 1;
        dialog_text = string_copy(dialog_full, 1, dialog_pos);
        dialog_timer = 0;
    }
}

// Si ya terminó de escribir y el jugador pulsa una tecla → pasa al siguiente diálogo
if (keyboard_check_pressed(vk_space)) {
    if (dialog_pos >= string_length(dialog_full)) {
        dialog_index += 1;
        if (dialog_index < array_length(dialogos)) {
            dialog_full = dialogos[dialog_index];
            dialog_text = "";
            dialog_pos = 0;
        } else {
            finished = true;
            // Transición a Lv1 solo desde la sala Start
            if (room_get_name(room) == "Start") {
                room_goto(Lv1);
            }
        }
    } else {
        // Si presiona espacio antes de terminar, muestra todo de golpe
        dialog_pos = string_length(dialog_full);
        dialog_text = dialog_full;
    }
}

// Aparición de personajes en ciertos diálogos (solo para Start)
if (room_get_name(room) == "Start") {
    switch(dialog_index) {
        case 1: show_ralsei = true; break;
        case 2: show_susie = true; break;
        case 3: show_kris   = true; break;
    }
    // Actualizar visibilidad en tiempo real
    oRalsei.visible = show_ralsei;
    oSusie.visible = show_susie;
    oKris.visible = show_kris;
}