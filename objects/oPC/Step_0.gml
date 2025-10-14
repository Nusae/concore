// Distancia máxima para detectar cercanía
var dist_max = 30;

// Detectar cercanía de cada personaje
var kris_cerca   = instance_exists(oKris)   && (point_distance(x, y, oKris.x, oKris.y) <= dist_max);
var ralsei_cerca = instance_exists(oRalsei) && (point_distance(x, y, oRalsei.x, oRalsei.y) <= dist_max);
var susie_cerca  = instance_exists(oSusie)  && (point_distance(x, y, oSusie.x, oSusie.y) <= dist_max);

// Inicializar variables globales si no existen
if (!variable_global_exists("msg_timer")) global.msg_timer = 0;
if (!variable_global_exists("msg_text")) global.msg_text = "";
if (!variable_global_exists("msg_speaker")) global.msg_speaker = noone;
if (!variable_global_exists("error_shown")) global.error_shown = false;

// ───────────────────────────────
// Mostrar mensajes con temporizador
// ───────────────────────────────

// Si solo Kris está cerca y aún no se mostró el error
if (kris_cerca && !ralsei_cerca && !susie_cerca) {
    image_index = 1; // sprite de error
    global.msg_text = "Hay un error.";
    global.msg_speaker = oKris;
    global.msg_timer = room_speed; // dura 1 segundo
    global.error_shown = true; // marcamos que ya se mostró
}
// Si hay otro personaje también y el error ya se mostró
else if (kris_cerca && (ralsei_cerca || susie_cerca) && global.error_shown) {
    image_index = 0; // sin error
    global.msg_text = "No hay nada.";
    global.msg_speaker = oKris;
    global.msg_timer = room_speed;
}
else {
    image_index = 0;
}

// Detener animación
image_speed = 0;

// Temporizador de mensaje
if (global.msg_timer > 0) {
    global.msg_timer--;
    if (global.msg_timer <= 0) {
        global.msg_text = "";
        global.msg_speaker = noone;
    }
}
