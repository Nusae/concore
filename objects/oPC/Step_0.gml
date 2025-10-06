// Distancia máxima para detectar cercanía
var dist_max = 30;

// Detectar cercanía de cada personaje
var kris_cerca   = instance_exists(oKris)   && (point_distance(x, y, oKris.x, oKris.y) <= dist_max);
var ralsei_cerca = instance_exists(oRalsei) && (point_distance(x, y, oRalsei.x, oRalsei.y) <= dist_max);
var susie_cerca  = instance_exists(oSusie)  && (point_distance(x, y, oSusie.x, oSusie.y) <= dist_max);

// Lógica del sprite mostrado
if (kris_cerca && !ralsei_cerca && !susie_cerca) {
    // Solo Kris está cerca → mostrar el segundo frame
    image_index = 1;
} else {
    // Si hay más de uno o nadie → primer frame
    image_index = 0;
}

// Aseguramos que la animación esté parada
image_speed = 0;
