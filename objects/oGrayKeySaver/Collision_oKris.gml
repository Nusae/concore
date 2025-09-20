if ( !used   && other.keys_gray > 0) {
    other.keys_gray -= 1;
	global.keys_gray += 1; 
	used = true; 
	anim_timer = anim_delay;
	other.y += 70;								//Para que una vez hayas entrado te teletransporta más adelante para mo poder evitarlo
}

