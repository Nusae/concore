// Diálogos específicos para Logic
dialogos = [
    "Bienvenido a la sala de operaciones. Aquí explicaremos los elementos del juego.",
    "Primero, el switch: Si no hay nadie encima, no se mueve.",
    "Con 1 persona, empieza a moverse lentamente.", 
    "Con 2 personas, se mueve más rápido.",  
    "¡Pero con 3, explota! Cuidado en los niveles reales.", 
    "Ahora, el botón: Solo puede haber una persona encima.",  
    "Si pones más de una, explota.",   
];

// Personajes visibles desde el inicio
show_ralsei = true;
show_susie = true;
show_kris = true;

// índice del diálogo actual
dialog_index = 0;

// control de escritura tipo Undertale (una letra a la vez)
dialog_text = "";
dialog_full = dialogos[dialog_index];
dialog_pos = 0;
dialog_speed = 2; // menor = más rápido
dialog_timer = 0;
finished = false;

// Control para saber si ya se mostró todo
finished = false;

if (string_length(dialog_full) > 0) {
    dialog_pos = 1;
    dialog_text = string_copy(dialog_full, 1, dialog_pos);
}
