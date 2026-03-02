draw_set_font(ft_tutorial);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _gui_w = display_get_gui_width();


draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 20, _gui_w, 100, false);
draw_set_alpha(1);
draw_set_color(c_white);


if (indice == -1) 
{
	
    draw_text(_gui_w / 2, 60, "[Pressione ESPAÇO]");
} 
else 
{
    draw_text(_gui_w / 2, 50, textos[indice]);
     
    draw_text(_gui_w / 2, 80, "(Espaço para avançar)");
}

// Resetando as configurações
draw_set_halign(-1);
draw_set_valign(-1);
draw_set_font(-1);