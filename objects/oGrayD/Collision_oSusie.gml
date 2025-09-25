if (!opened) {
    if (global.keys_gray > 0) {
        other.keys_gray += 1;
		global.keys_gray -= 1; 
        opened = true;
		sprite_index = sFDoorOpened;
        solid = false; // Se abre
		
    } else {
        global.sentado_susie = true; 
    }
}
