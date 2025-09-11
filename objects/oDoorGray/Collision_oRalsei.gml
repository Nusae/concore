if (!opened) {
    if (global.keys_gray > 0) {
        other.keys_gray += 1;
		global.keys_gray -= 1; 
        opened = true;
		sprite_index = sFDoorOpened;
        solid = false; // Se abre
		global.sentado_gray = 0; 
    } else {
        global.sentado_ralsei = true;
		other.movimiento_habilitado = false; 
    }
}
