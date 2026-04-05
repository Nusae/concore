// Evento Room Start (Other 4)
// --- Resetear vistas al cambiar de sala para evitar "fantasmas" del nivel anterior ---

// 1. Apagar todas las vistas excepto la principal
view_visible[0] = true;
for (var i = 1; i < 8; i++) {
    view_visible[i] = false;
}

// 2. Configurar la cámara 0 y sus bordes para centrar al personaje
var cam = view_camera[0];
camera_set_view_border(cam, 225, 150);

// 3. Asegurar que la cámara 0 sigue a Kris al empezar (o al personaje líder)
if (instance_exists(oKris)) {
    camera_set_view_target(cam, oKris);
} else if (instance_exists(oRalsei)) {
    camera_set_view_target(cam, oRalsei);
} else if (instance_exists(oSusie)) {
    camera_set_view_target(cam, oSusie);
}
