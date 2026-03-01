randomise()

timer--;

// Condição de Vitória: O player mogou todo mundo
if (instance_number(obj_inimigo) == 0)
{
    show_message("Sobreviveste à maldição!"); 
    room_goto(rm_game); // Volta para a glória do mundo comum
}

// O player não conseguiu limpar a tempo... dobra e o proximo é ele
if (timer <= 0) {
    qtd_inimigos *= 2; // Dobra a quantidade da próxima onda
    timer = tempo_maximo; // Reinicia o cronometro
    
    // Spawna os inimigos novos, mas com o freio de mão puxado no 30!
    repeat(qtd_inimigos) 
	{
        // A TRAVA DE SEGURANÇA: Se já tem 30 ou mais, para de spawnar imediatamente!
        if (instance_number(obj_inimigo) >= max_inimigos) {
            break; 
        }

        // Gera inimigos numa posição aleatória 
        var _x = irandom_range(100, room_width - 100);
        var _y = choose(50, 100, 150, 200); 
        
        instance_create_layer(_x, _y, "Instances", obj_inimigo);
    }
}