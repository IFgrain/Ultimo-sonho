timer--;

// Condição de Vitória: O player mogou todo mundo
if (instance_number(obj_inimigo) == 0)
{
    show_message("Sobreviveste à maldição!"); 
    room_goto(rm_game); // Ai ele volta para o mundo comum
}

// O player não cconseguiu e foi mogado
if (timer <= 0) {
    qtd_inimigos *= 2; // Dobra a quantidade de inimigos inicial
    timer = tempo_maximo; // Reinicia o cronometro
    
    // Spawna o dobro dos inimigos para mogar o jogador
    repeat(qtd_inimigos) 
	{
        // Gera inimigos numa posição aleatória 
        var _x = irandom_range(100, room_width - 100);
        instance_create_layer(_x, 100, "Instances", obj_inimigo);
    }
}