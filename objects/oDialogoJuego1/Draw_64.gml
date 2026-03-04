draw_set_font(fnt_espanol);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

/// =====================================================
/// CUADRO PRINCIPAL TIPO UNDERTALE
/// =====================================================

if (!finished && dialog_text != "")
{
    var border_thickness = 4;

    draw_set_color(c_white);
    for (var i = 0; i < border_thickness; i++)
    {
        draw_rectangle(50 - i, gui_h - 150 - i,
                       gui_w - 50 + i, gui_h - 50 + i, true);
    }

    draw_set_color(c_black);
    draw_rectangle(50, gui_h - 150,
                   gui_w - 50, gui_h - 50, false);

    /// =============================
    /// ORDENADOR
    /// =============================
    if (string_pos("Ordenador:", dialog_text) == 1)
    {
        draw_set_color(c_red);
        draw_text(70, gui_h - 130,
                  string_delete(dialog_text, 1, 10));
    }

    /// =============================
    /// SISTEMA
    /// =============================
    else if (string_pos("Sistema:", dialog_text) == 1)
    {
        draw_set_color(c_white);
        draw_text(70, gui_h - 130,
                  string_delete(dialog_text, 1, 9));
    }

    /// =============================
    /// TODOS (colores alternados)
    /// =============================
    else if (string_pos("Todos:", dialog_text) == 1)
    {
        var msg = string_delete(dialog_text, 1, 6);
        var x_start = 70;
        var y_pos = gui_h - 130;
        var max_width = gui_w - 100;
        var current_width = 0;

        for (var i = 1; i <= string_length(msg); i++)
        {
            var ch = string_char_at(msg, i);
            var ch_width = string_width(ch);

            if (current_width + ch_width > max_width)
            {
                y_pos += 20;
                x_start = 70;
                current_width = 0;
            }

            var col_index = (i - 1) mod 3;

            switch (col_index)
            {
                case 0: draw_set_color(c_aqua); break;
                case 1: draw_set_color(c_yellow); break;
                case 2: draw_set_color(c_lime); break;
            }

            draw_text(x_start, y_pos, ch);

            x_start += ch_width;
            current_width += ch_width;
        }
    }
}

/// =====================================================
/// BURBUJAS DE PERSONAJES (SIEMPRE ENCIMA DE TODO)
/// =====================================================

if (global.msg_text != "" && global.msg_speaker != noone)
{
    if (instance_exists(global.msg_speaker))
    {
        draw_set_font(fnt_espanol);

        // Convertir coordenadas del mundo a GUI
        var cam = view_camera[0];
        var cam_x = camera_get_view_x(cam);
        var cam_y = camera_get_view_y(cam);

        var px = global.msg_speaker.x - cam_x +150;
        var py = global.msg_speaker.y - cam_y;


        var text = global.msg_text;

        var half_width = 60;
        var text_width = half_width * 1.8;

        var text_height = string_height_ext(text, -1, text_width);
        var half_height = (text_height / 2) + 15;

        // Fondo
        draw_set_color(c_black);
        draw_roundrect(px - half_width, py - half_height,
                       px + half_width, py + half_height, false);

        // Borde
        draw_set_color(c_white);
        draw_roundrect(px - half_width, py - half_height,
                       px + half_width, py + half_height, true);

        // Color según personaje
        if (global.msg_speaker == oSusie)
            draw_set_color(c_aqua);
        else if (global.msg_speaker == oRalsei)
            draw_set_color(c_lime);
        else if (global.msg_speaker == oKris)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);

        draw_text_ext(px - half_width + 10,
                      py - half_height + 5,
                      text, -1, text_width);

        draw_set_font(fnt_espanol);
    }
}