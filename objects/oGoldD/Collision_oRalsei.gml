if(global.commandmode){
	timer += 1;

	if (timer >= room_speed * 3) {
	    if (!opened) {
	        if (global.keys_golden > 0) {
	            other.keys_golden += 1;
	            global.keys_golden -= 1; 
	            opened = true;
	            sprite_index = sAuDoorOpened; 
	        } else {
	            global.sentado_ralsei = true; 
	        }
	    }
	}
}else{
	if (!opened) {
	    if (global.keys_golden > 0) {
	        other.keys_golden += 1;
			global.keys_golden -= 1; 
	        opened = true;
			sprite_index = sAuDoorOpened;
	        solid = false;  
	    } else {
	        global.sentado_ralsei= true; 	
		}
	}
}