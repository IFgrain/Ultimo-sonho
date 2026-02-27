var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

draw_set_font(ft_padrao)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

var tam_menu = array_length(menu_opcs)
for (var i = 0; i < tam_menu; i++)
{
	var _wgui = display_get_gui_width()
	var _hgui = display_get_gui_height()
	
	var hstr = string_height("I")
	var wstr = string_width(menu_opcs[i])
	
	var x1 = _wgui / 2 - wstr / 2;
	var y1 =  _hgui / 2 - hstr/ 2 + hstr * i;
	
	var x2 = _wgui / 2 + wstr / 2
	var y2 =  _hgui / 2 + hstr/ 2 + hstr * i
	
	if (point_in_rectangle(_mx, _my, x1, y1, x2, y2))
	{
		esc[i] = lerp(esc[i], 1.4, 0.15)
		if (mouse_check_button_pressed(mb_left))
		{
					switch menu_opcs[i]
		{
			case menu_opcs[0]:
			room_goto(rm_game);
			break;
			
			case menu_opcs[1]:
			show_message("Tem não chefia");
			break;
			
			case menu_opcs[2]:
			game_end();
			break;
		}
		}
	}
	else 
	{
		esc[i] = lerp(esc[i], 1, 0.15)
	}
	
	draw_text_transformed(_wgui / 2, _hgui / 2 + hstr * i, menu_opcs[i], esc[i], esc[i], 0);
}

draw_set_font(-1);
draw_set_halign(-1);
draw_set_valign(-1);