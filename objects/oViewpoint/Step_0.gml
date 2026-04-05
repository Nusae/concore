// Evento Step del objeto oViewpoint
// --- Gestión dinámica de cámaras y objetivos ---

// Asegurar que solo la vista 0 está activa y bien configurada
view_visible[0] = true;
view_visible[1] = false;
view_visible[2] = false;

// Configurar bordes de la cámara para centrar al personaje
// Basado en hview:450, wview:300 (valores típicos del proyecto)
var cam = view_camera[0];
camera_set_view_border(cam, 225, 150);

// --- 1. Cambio manual con Z, X, C ---
if (keyboard_check_pressed(ord("Z"))) {
    if (instance_exists(oKris)) camera_set_view_target(cam, oKris);
}
if (keyboard_check_pressed(ord("X"))) {
    if (instance_exists(oRalsei)) camera_set_view_target(cam, oRalsei);
}
if (keyboard_check_pressed(ord("C"))) {
    if (instance_exists(oSusie)) camera_set_view_target(cam, oSusie);
}

// --- 2. Cambio automático por movimiento ---

// Kris (Flechas)
if (keyboard_check(vk_up) || keyboard_check(vk_down) || keyboard_check(vk_left) || keyboard_check(vk_right)) {
    if (instance_exists(oKris)) camera_set_view_target(cam, oKris);
}

// Ralsei (WASD)
if (keyboard_check(ord("W")) || keyboard_check(ord("A")) || keyboard_check(ord("S")) || keyboard_check(ord("D"))) {
    if (instance_exists(oRalsei)) camera_set_view_target(cam, oRalsei);
}

// Susie (UHJK)
if (keyboard_check(ord("U")) || keyboard_check(ord("H")) || keyboard_check(ord("J")) || keyboard_check(ord("K"))) {
    if (instance_exists(oSusie)) camera_set_view_target(cam, oSusie);
}
