if (!used) {
    draw_sprite(sprite_index, image_index, x, y); // Sprite normal si no se ha usado
} else if (anim_timer > 0) {
    // Animación: rota sKeyHalf, sKeySilverSaver, sKeySaver a ~0.6 FPS
    var frame = (anim_timer mod 300); // Ciclo de 300 frames (100 por sprite)
    if (frame < 100) draw_sprite(sKeyHalf, 0, x, y); // ~1.67s
    else if (frame < 200) draw_sprite(sKeySilverSaver, 0, x, y); // ~1.67s
    else draw_sprite(sKeySaver, 0, x, y); // ~1.67s
} else {
    // Animación terminada: sprite normal + sKeySaver
    draw_sprite(sprite_index, image_index, x, y);
    draw_sprite(sKeySaver, 0, x, y);
}