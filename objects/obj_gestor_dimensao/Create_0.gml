// Professor ensinou isso também
randomize(); 

tempo_maximo = 60 * 60; 
timer = tempo_maximo;
qtd_inimigos = 10;      
max_inimigos = 30;   

// Spawn inicial 
repeat(qtd_inimigos)
{
    var _x = irandom_range(100, room_width - 100); 
    var _y = choose(50, 100, 150, 200); 
    
    instance_create_layer(_x, _y, "Instances", obj_inimigo);
}