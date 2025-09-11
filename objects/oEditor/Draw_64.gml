// oEditor: Draw GUI

draw_text(20, 20, "Editor - Usa 5 6 para cambiar objeto, click para colocar");

var icon_x = 20;
var icon_y = 60;
var obj = menu_items[selected_index].obj;

// Dibujar sprite del objeto seleccionado
if (object_exists(obj)) {
    var spr = object_get_sprite(obj);
    if (spr != -1) {
        draw_sprite(spr, 0, icon_x, icon_y);
    }
}

draw_text(icon_x + 40, icon_y + 8, menu_items[selected_index].name);

// Mostrar contadores de llaves
draw_text(20, icon_y + 60, "Gray Keys: " + string(global.keys_gray) + " (1/2)");
draw_text(20, icon_y + 80, "Gold Keys: " + string(global.keys_golden) + " (3/4)");


//Visual de la pantalla de fallo	
if (global.show_fail_window) {
    // Fondo semi-transparente
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(10, 100, 500, 200, false);
    draw_set_alpha(1);
    
    // Texto del mensaje
    draw_set_color(c_white);
    draw_text(100, 130, "¡Has fallado!\nPulsa 8 para repetir");
}
