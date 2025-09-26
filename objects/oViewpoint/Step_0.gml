// Evento Step del objeto controlador
if (keyboard_check_pressed(ord("Z"))) {
    view_enabled = true; // asegurar que las views estén activas
    view_visible[0] = true;
    view_visible[1] = false;
    view_visible[2] = false;
}

if (keyboard_check_pressed(ord("X"))) {
    view_enabled = true;
    view_visible[0] = false;
    view_visible[1] = true;
    view_visible[2] = false;
}

if (keyboard_check_pressed(ord("C"))) {
    view_enabled = true;
    view_visible[0] = false;
    view_visible[1] = false;
    view_visible[2] = true;
}
