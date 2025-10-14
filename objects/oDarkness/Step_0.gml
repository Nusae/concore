// Asegurar que la superficie exista
if (!surface_exists(light_surface)) {
    light_surface = surface_create(room_width, room_height);
}
