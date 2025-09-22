

if (keyboard_check_pressed(ord("8"))) {
    global.show_fail_window = false;
    global.explode = false;
    room_restart(); 
}


if(global.explode){
	global.show_fail_window = true;
}
