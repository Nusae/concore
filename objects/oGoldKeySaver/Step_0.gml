if (anim_timer > 0) {
    anim_timer -= 1;
}

if (used) {
    // Solo se vuelve sólido si NINGÚN personaje está encima
    if (
        !place_meeting(x, y, oKris) &&
        !place_meeting(x, y, oRalsei) &&
        !place_meeting(x, y, oSusie)
    ) {
        solid = true;
    }
		global.sentado_kris = false; 
		global.sentado_susie = false; 
		global.sentado_ralsei = false; 
}
