if ( !used  && other.keys_golden > 0) {
    other.keys_golden -= 1;
	global.keys_golden +=1; 
	used = true; 
	anim_timer = anim_delay;

}
