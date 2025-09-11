if (!opened) {
    if (global.keys_golden > 0) {
        other.keys_golden += 1;
		global.keys_golden -= 1; 
        opened = true;
		sprite_index = sAuDoorOpened1;
        solid = false;  
    } else {
        global.sentado_ralsei= true; 
		other.movimiento_habilitado = false; 
    }
}
