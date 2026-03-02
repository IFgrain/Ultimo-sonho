mus_menu.Stop();
mus_jogo.Stop();
amb_jogo.Stop();


if (room == rm_menu) 
{
    mus_jogo.Stop(); 
    mus_dime.Stop(); 
    amb_jogo.Stop();
    mus_menu.PlayLoop();
    
    global.venceu_dimensao = false; 
}
else if (room == rm_game)
{
    mus_jogo.PlayLoop();
}

else if (room == rm_dimensao) 
{
    mus_jogo.Stop();
    mus_dime.PlayLoop(); 
}