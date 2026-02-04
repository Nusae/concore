   
if (keyboard_check_pressed(ord("8"))) {
    global.show_fail_window = false;
    global.explode = false;
    room_restart(); 
}



if(global.explode || ( global.sentado_kris == 1 && global.sentado_susie == 1 && global.sentado_ralsei == 1)){
	global.show_fail_window = true;
	oKris.sprite_index = sKrisSat;
	oSusie.sprite_index = sSusieSat;
	oRalsei.sprite_index = sRalseiSat;
}
