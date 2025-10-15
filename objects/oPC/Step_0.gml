// Ejecutar solo si estamos en la sala "Logic"
if (room_get_name(room) == "Logic") {
    
    // Distancia máxima para detectar cercanía
    var dist_max = 60;

    // Detectar cercanía de cada personaje
    var kris_cerca   = instance_exists(oKris)   && (point_distance(x, y, oKris.x, oKris.y) <= dist_max);
    var ralsei_cerca = instance_exists(oRalsei) && (point_distance(x, y, oRalsei.x, oRalsei.y) <= dist_max);
    var susie_cerca  = instance_exists(oSusie)  && (point_distance(x, y, oSusie.x, oSusie.y) <= dist_max);

    // Inicializar variables globales si no existen
    if (!variable_global_exists("msg_timer")) global.msg_timer = 0;
    if (!variable_global_exists("msg_text")) global.msg_text = "";
    if (!variable_global_exists("msg_speaker")) global.msg_speaker = noone;
    if (!variable_global_exists("error_shown")) global.error_shown = false;
    if (!variable_global_exists("susie_analyzed")) global.susie_analyzed = false;

    // ───────────────────────────────
    // Mostrar mensajes con temporizador
    // ───────────────────────────────

    // Si solo Kris está cerca y aún no se mostró el error
    if (kris_cerca && !ralsei_cerca && !susie_cerca) {
        image_index = 1; // Sprite de error
        global.msg_text = "Hay un error.";
        global.msg_speaker = oKris;
        global.msg_timer = room_speed; // Dura 1 segundo
        global.error_shown = true; // Marcamos que ya se mostró
    }
    // Si Susie está cerca y no se ha realizado el análisis
    else if (susie_cerca && !global.susie_analyzed) {
        // Mostrar mensaje técnico
        image_index = 0; // Sin error
        global.msg_text = "Analizando sistema: protocolos de datos intactos, sin anomalías detectadas.";
        global.msg_speaker = self; // El objeto mismo habla
        global.msg_timer = room_speed * 2; // Dura 2 segundos
        
        // Marcar análisis como completo cuando el mensaje termina
        if (global.msg_timer == 1) {
            global.susie_analyzed = true; // Marcamos que el análisis ya ocurrió
        }
    }
    // Si Susie está cerca y el análisis ya se realizó
    else if (susie_cerca && global.susie_analyzed) {
        image_index = 0; // Sin error
        global.msg_text = "No pasa nada.";
        global.msg_speaker = oSusie; // Susie habla
        global.msg_timer = room_speed; // Dura 1 segundo
    }
    // Si hay otro personaje también y el error ya se mostró
    else if (kris_cerca && (ralsei_cerca || susie_cerca) && global.error_shown) {
        image_index = 0; // Sin error
        global.msg_text = "No hay nada.";
        
        // Asignar hablante: Ralsei si está cerca, de lo contrario Susie
        if (ralsei_cerca) {
            global.msg_speaker = oRalsei;
        } else if (susie_cerca) {
            global.msg_speaker = oSusie;
        }
        
        global.msg_timer = room_speed;
    }
    // Si no hay nadie cerca o ninguna condición especial
    else {
        image_index = 0; // Sin error
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
}
else {
    // Si NO estamos en la sala Logic, aseguramos que no se muestre nada
    global.msg_text = "";
    global.msg_speaker = noone;
}
