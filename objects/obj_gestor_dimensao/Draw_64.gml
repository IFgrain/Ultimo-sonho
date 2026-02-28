draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(ft_padrao); 
draw_set_color(c_red); 

// Converte os frames em segundos (ceil arredonda para cima)
var _segundos = ceil(timer / 60);

draw_text(display_get_gui_width() / 2, 50, "TEMPO: " + string(_segundos));

// Reseta tudo
draw_set_color(c_white);
draw_set_halign(-1);
draw_set_valign(-1);
draw_set_font(-1); 