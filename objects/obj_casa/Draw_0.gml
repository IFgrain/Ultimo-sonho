draw_self(); // Desenha a casa normalmente

if (place_meeting(x, y, obj_player)) {
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(x, y - 100, "Aperte E para Entrar"); // O aviso aparece em cima da casa!
    draw_set_halign(-1);
}