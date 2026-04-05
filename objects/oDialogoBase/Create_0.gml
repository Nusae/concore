// Variables base de diálogo
dialog_timer = 0;
dialog_speed = 2; 
dialog_pos = 0;
dialog_text = "";
dialog_full = "";
dialog_index = 0;
finished = false;

// Lista de diálogos (se debe llenar en el hijo)
dialogos = [];

// Inicialización de burbujas global
if (!variable_global_exists("msg_text")) global.msg_text = "";
if (!variable_global_exists("msg_speaker")) global.msg_speaker = noone;
if (!variable_global_exists("msg_timer")) global.msg_timer = 0;
