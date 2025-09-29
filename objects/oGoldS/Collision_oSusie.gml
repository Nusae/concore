timer += 1;


if (timer >= room_speed * 1){
    if (!used && other.keys_golden > 0) {
        other.keys_golden -= 1;
        global.keys_golden += 1; 
        used = true; 
        anim_timer = anim_delay;
        if (!global.commandmode) {
            other.y += 70;
        }
    }
}