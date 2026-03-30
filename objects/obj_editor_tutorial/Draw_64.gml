/// @description Dibujar tutorial
var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_set_alpha(alpha * 0.9);
draw_set_color(c_black);
draw_rectangle(0, 0, _w, _h, false);

draw_set_alpha(alpha);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _txt = "--- GUIA RAPIDA DEL EDITOR ---\n\n" +
           "GENERAL:\n" +
           "[Click Izq]: Colocar objeto | [Botón 5/6]: Siguiente/Anterior objeto\n" +
           "[1/2]: Ajustar Llaves Grises | [3/4]: Ajustar Llaves Doradas\n" +
           "[Alt]: Abrir consola de comandos (Source Code)\n\n" +
           "SISTEMA DE NIVELES:\n" +
           "[G]: Abrir GALERIA de niveles guardados\n" +
           "[S]: Guardar nivel (por defecto) | [L]: Cargar nivel (por defecto)\n" +
           "[N]: Nuevo guardado con fecha y hora\n" +
           "[C]: COPIAR 'Código de Nivel' al portapapeles\n" +
           "[V]: PEGAR 'Código de Nivel' desde portapapeles\n\n" +
           "VISTAS:\n" +
           "[Z/X/C]: Cambiar cámara manualmente\n" +
           "(O simplemente muévelos con Flechas, WASD o UHJK)\n\n" +
           "--- PULSA CUALQUIER TECLA PARA EMPEZAR ---";

draw_text_transformed(_w / 2, _h / 2, _txt, 1, 1, 0);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
