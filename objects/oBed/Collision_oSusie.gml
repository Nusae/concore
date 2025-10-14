/// Evento de colisión: oBed <-> oKris
if (sprite_index == sBed) {
    // Si la cama está vacía (sin ocupante)
    if (!variable_instance_exists(id, "occupant") || occupant == noone) {

        // Cambiar a la imagen ocupada
        image_index = 1;

        // Ocultar el personaje
        //other.sprite_index = sBed;

        // Guardar quién está dentro
        occupant = other.id;
        
        // Desactivar su movimiento
        other.movimiento_habilitado = false; 

        // Marcar que el personaje está en cama
        if (other.object_index == oKris)   global.kris_cama = true;
        if (other.object_index == oSusie)  global.susie_cama = true;
        if (other.object_index == oRalsei) global.ralsei_cama = true;

    } else {
        // Si ya hay alguien en la cama, no hacer nada (ni permitir acostarse)
        show_debug_message("Esta cama ya está ocupada.");
    }
}
