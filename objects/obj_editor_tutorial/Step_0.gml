/// @description Cerrar tutorial
alpha = lerp(alpha, target_alpha, fade_speed);

if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any)) {
    target_alpha = 0;
}

if (target_alpha == 0 && alpha < 0.05) {
    instance_destroy();
}
