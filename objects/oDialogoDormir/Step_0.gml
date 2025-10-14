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
            // y SOLO si todos los personajes están en cama
            if (room_get_name(room) == "Sleep")                
                room_goto(Lv2);
            
        }
    } else {
        // Si presiona espacio antes de terminar, muestra todo de golpe
        dialog_pos = string_length(dialog_full);
        dialog_text = dialog_full;
    }
}
