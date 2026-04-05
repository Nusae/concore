// Susie no tiene bloqueo específico propio en el código original, 
// pero podemos inicializarlo por si acaso.
is_blocked_specific = false;

// Llamar a la lógica base (Movimiento y Comandos)
event_inherited();

//--------------
// LÓGICA DE ESTADO ESPECÍFICA
//-------------------------

if (global.keys_gray > 0) {
    global.sentado_susie = false;
    global.sentado_gray = 0;
    movimiento_habilitado = true;
    move_spd = 1;
}
if (global.keys_golden > 0) {
    global.sentado_susie = false;
    global.sentado_gold = 0;
    movimiento_habilitado = true;
    move_spd = 1;
}

if (global.susie_cama == true) {
    visible = false; 
}