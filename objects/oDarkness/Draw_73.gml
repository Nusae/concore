if (surface_exists(light_surface)) {
    surface_set_target(light_surface);
    draw_clear_alpha(c_black, 0.5);

    // 🔥 Modo de mezcla personalizado (restar luz del negro)
    // bm_zero = 0
    // bm_one_minus_src_color = 8
    gpu_set_blendmode_ext(0, 8);
    draw_set_color(c_white);

    // 💡 Dibujar las luces (Lava Lamps)
    with (oLavaLamp) {
        var luz_x = x;
        var luz_y = y;
        var radio = 50;
        draw_circle(luz_x, luz_y, radio, false);
    }

    // 🔄 Restaurar modo normal
    gpu_set_blendmode(0); // equivalente a bm_normal
    surface_reset_target();

    // Dibujar la superficie de oscuridad encima de todo
    draw_surface(light_surface, 0, 0);
}
