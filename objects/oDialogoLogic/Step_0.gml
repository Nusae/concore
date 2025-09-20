if (!finished) {
    dialog_timer += 1;
    if (dialog_timer >= dialog_speed && dialog_pos < string_length(dialog_full)) {
        dialog_pos += 1;
        dialog_text = string_copy(dialog_full, 1, dialog_pos);
        dialog_timer = 0;
    }
}

// Si ya terminó de escribir y el jugador pulsa una tecla → pasa al siguiente diálogo
if (keyboard_check_pressed(vk_space)) {  // Cambia a vk_enter si prefieres "intro"
    if (dialog_pos >= string_length(dialog_full)) {
        dialog_index += 1;
        if (dialog_index < array_length(dialogos)) {
            dialog_full = dialogos[dialog_index];
            dialog_text = "";
            dialog_pos = 0;
        } else {
            finished = true;
            // Transición a Lv1 después del tutorial
            room_goto(Lv1);  // O a donde quieras ir después
        }
    } else {
        // Si presiona espacio antes de terminar, muestra todo de golpe
        dialog_pos = string_length(dialog_full);
        dialog_text = dialog_full;
    }
}

switch(dialog_index) {
    case 8: // Antes de "Ahora prueba a ir a la puerta con Kris"
        if (instance_exists(oKris)) {
            global.keys_golden = 1; // Dar llave dorada a Kris
        }
        break;
}


// Actualizar visibilidad (por si acaso)
if (instance_exists(oRalsei)) oRalsei.visible = show_ralsei;
if (instance_exists(oSusie)) oSusie.visible = show_susie;
if (instance_exists(oKris)) oKris.visible = show_kris;