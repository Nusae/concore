//--------------
// LÓGICA BASE DE DIÁLOGO (Typewriter & Input)
//-------------------------

// 0. INICIALIZAR DIÁLOGO ACTUAL
if (array_length(dialogos) > 0 && !finished) {
    if (dialog_full == "") {
        var next_full = dialogos[dialog_index];
        
        // Detectar prefijo para que el typewriter empiece DESPUÉS del nombre
        var prefix = "";
        if (string_pos("Kris:", next_full) == 1) prefix = "Kris: ";
        else if (string_pos("Susie:", next_full) == 1) prefix = "Susie: ";
        else if (string_pos("Ralsei:", next_full) == 1) prefix = "Ralsei: ";
        else if (string_pos("Ordenador:", next_full) == 1) prefix = "Ordenador: ";
        else if (string_pos("Sistema:", next_full) == 1) prefix = "Sistema: ";
        else if (string_pos("Todos:", next_full) == 1) prefix = "Todos: ";
        
        dialog_full = next_full;
        dialog_pos = string_length(prefix);
        dialog_text = prefix;
        dialog_timer = 0;
    }
}

// 1. PROCESO DE ESCRITURA (TYPEWRITER)
if (!finished && dialog_full != "" && dialog_pos < string_length(dialog_full)) {
    dialog_timer += 1;
    if (dialog_timer >= dialog_speed) {
        dialog_pos += 1;
        dialog_text = string_copy(dialog_full, 1, dialog_pos);
        dialog_timer = 0;
    }
}

// 2. MANEJAR INPUT (Espacio)
if (keyboard_check_pressed(vk_space)) {
    // Si ya terminó de escribir → pasa al siguiente
    if (dialog_pos >= string_length(dialog_full)) {
        dialog_index += 1;
        if (dialog_index < array_length(dialogos)) {
            dialog_full = ""; // Forzar reinicialización en el siguiente frame
        } else {
            finished = true;
            global.msg_text = "";
            global.msg_speaker = noone;
        }
    } else {
        // Saltar typewriter: muestra todo de golpe
        dialog_pos = string_length(dialog_full);
        dialog_text = dialog_full;
    }
}
