mus_menu.Stop();
mus_jogo.Stop();
amb_jogo.Stop();


if (room == rm_menu) {
    mus_menu.PlayLoop();
} 
else if (room == rm_game) {
    mus_jogo.PlayLoop();
    amb_jogo.PlayLoop();
}