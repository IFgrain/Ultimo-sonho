tempo_maximo = 60 * 60; 
timer = tempo_maximo;
qtd_inimigos = 3; // Quantidade inicial de inimigos a spawnar

// Spawn inicial 
repeat(qtd_inimigos)
{
    instance_create_layer(irandom_range(100, room_width-100), 200, "Instances", obj_inimigo);
}