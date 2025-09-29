if(global.commandmode){
	timer += 1;

	if (timer >= room_speed * 2){
	    if (!used && other.keys_gray > 0) {
	        other.keys_gray -= 1;
	        global.keys_gray += 1; 
	        used = true; 
	        anim_timer = anim_delay;
	        if (!global.commandmode) {
	            other.y += 70;
	        }
	    }
	}
}else{
	if ( !used   && other.keys_gray > 0) {
	    other.keys_gray -= 1;
		global.keys_gray += 1; 
		used = true; 
		anim_timer = anim_delay;
		if(!global.commandmode){ other.y += 70;}
	}
}