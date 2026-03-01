var _wgui = display_get_gui_width();
var _hgui = display_get_gui_height();
var _centro_x = _wgui / 2;

// 1. A Película Escura de Fundo
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0, 0, _wgui, _hgui, false);
draw_set_alpha(1);

// 2. A Logo Flutuante (Ajustada para o tamanho da arte do Levy!)
var _flutuar = sin(current_time / 300) * 10; 
// O 0.5 ali no meio encolhe a logo gigante pela metade. Ajuste se precisar!
draw_sprite_ext(spr_titulo, 0, _centro_x, (_hgui * 0.25) + _flutuar, 0.5, 0.5, 0, c_white, 1);

// 3. Configurações de Texto
draw_set_font(ft_padrao);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _y_inicial = _hgui / 2 + 50;

var _alguem_com_hover = false; // Flag para saber se o mouse saiu de todas as opções

// 4. O Loop das Opções
for (var i = 0; i < array_length(menu_opcs); i++) 
{
    var _texto = menu_opcs[i];
    var _txt_w = string_width(_texto);
    var _txt_h = string_height(_texto);
    var _pos_y = _y_inicial + (i * espacamento);

    var _hover = point_in_rectangle(_mx, _my, _centro_x - _txt_w/2, _pos_y - _txt_h/2, _centro_x + _txt_w/2, _pos_y + _txt_h/2);

    var _escala = 1; // Escala padrão do texto

    if (_hover) 
    {
        _alguem_com_hover = true;
        
        // O SOM DO HOVER
        if (hover_atual != i) 
        {
            if (instance_exists(obj_snd)) obj_snd.sfx_hover.play = true; 
            hover_atual = i; 
        }

        // O JUICE
        var _cor_arco_iris = make_color_hsv((current_time / 10) % 255, 255, 255);
        draw_set_color(_cor_arco_iris);
        _escala = 1.2; 
        _pos_y -= 5;   

        // CLIQUE 
        if (mouse_check_button_pressed(mb_left)) 
        {
            if (instance_exists(obj_snd)) obj_snd.sfx_click.play = true;
            
            if (i == 0) room_goto(rm_game);
            if (i == 1) show_message("Tem não chefia"); 
            if (i == 2) game_end();
        }
    } 
    else 
    {
        draw_set_color(c_white); // Branco normal se não tiver mouse em cima
    }

    // Desenha o texto com a escala variável
    draw_text_transformed(_centro_x, _pos_y, _texto, _escala, _escala, 0);
}

// Reseta o hover_atual se o mouse não estiver em cima de NADA
if (!_alguem_com_hover) {
    hover_atual = -1;
}

// Resentando para não quebrar o resto do jogo
draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(-1);
draw_set_valign(-1);