// Evento Step del objeto controlador
// Evento Step del objeto controlador
// --- Cambio manual con Z, X, C ---
if (keyboard_check_pressed(ord("Z"))) {
    view_visible[0] = true; view_visible[1] = false; view_visible[2] = false;
}
if (keyboard_check_pressed(ord("X"))) {
    view_visible[0] = false; view_visible[1] = true; view_visible[2] = false;
}
if (keyboard_check_pressed(ord("C"))) {
    view_visible[0] = false; view_visible[1] = false; view_visible[2] = true;
}

// --- Cambio automático por movimiento ---
// Kris (Flechas) -> View 0
if (keyboard_check(vk_up) || keyboard_check(vk_down) || keyboard_check(vk_left) || keyboard_check(vk_right)) {
    if (!view_visible[0]) {
        view_visible[0] = true; view_visible[1] = false; view_visible[2] = false;
    }
}
// Ralsei (WASD) -> View 1
if (keyboard_check(ord("W")) || keyboard_check(ord("A")) || keyboard_check(ord("S")) || keyboard_check(ord("D"))) {
    if (!view_visible[1]) {
        view_visible[0] = false; view_visible[1] = true; view_visible[2] = false;
    }
}
// Susie (UHJK) -> View 2
if (keyboard_check(ord("U")) || keyboard_check(ord("H")) || keyboard_check(ord("J")) || keyboard_check(ord("K"))) {
    if (!view_visible[2]) {
        view_visible[0] = false; view_visible[1] = false; view_visible[2] = true;
    }
}
