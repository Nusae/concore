if (!opened) {
    if (global.keys_golden > 0) {
        other.keys_golden += 1;
		global.keys_golden -= 1; 
        opened = true;
		sprite_index = sAuDoorOpened1;
        solid = false;  
		global.sentado_gold = 0;
    } else {
        global.sentado_kris= true; 
    }
}
