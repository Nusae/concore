// --- Inicialización global base para todos los niveles ---

global.commandmode = false; 
global.tempmode = false; 
global.keys_golden = 0; 
global.keys_gray = 0;   
global.sentado_susie = 0;
global.sentado_kris = 0;
global.sentado_ralsei = 0; 

global.show_fail_window = false; 
global.explode = false;

// Reiniciar llaves en los objetos de personaje
if (instance_exists(oKris)) { oKris.keys_golden = 0; oKris.keys_gray = 0; }
if (instance_exists(oSusie)) { oSusie.keys_golden = 0; oSusie.keys_gray = 0; }
if (instance_exists(oRalsei)) { oRalsei.keys_golden = 0; oRalsei.keys_gray = 0; }

// Por defecto usamos sWall para el controlador si necesita sprite
sprite_index = sWall; 
visible = true;
