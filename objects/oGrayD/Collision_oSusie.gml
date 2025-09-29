if(global.commandmode){
	timer += 1;

	if (timer >= room_speed * 3) {
	    if (!opened) {
	        if (global.keys_gray > 0) {
	            other.keys_gray += 1;
	            global.keys_gray -= 1; 
	            opened = true;
	            sprite_index = sFDoorOpened; 
	        } else {
	            global.sentado_susie = true; 
	        }
	    }
	}
} else {
	if (!opened) {
	    if (global.keys_gray > 0) {
	        other.keys_gray += 1;
			global.keys_gray -= 1; 
	        opened = true;
			sprite_index = sFDoorOpened;
	        solid = false;  
	    }else {
	        global.sentado_susie= true; 
		}
	}
}