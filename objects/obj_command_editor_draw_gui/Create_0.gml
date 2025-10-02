/// @description Initialize command editor variables
selected_char = 0;    // Índice para personaje (0 = Ralsei, 1 = Kris, 2 = Susie)
selected_action = 0;  // Índice para acción (0 = move_to)
selected_target = 0;  // Índice para target (0 = Wall, 1 = Ball)
prev_action     = 0;

last_enter_frame = -1;
enter_processed = false;

// Inicializar listas de comandos vacías
commands_ralsei = [];
commands_kris   = [];
commands_susie  = [];
