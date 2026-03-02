
if (keyboard_check_pressed(vk_space)) 
{
    indice++;
    
    // Se o texto acabou, o tutorial se destrói e o jogo começa!
    if (indice >= array_length(textos)) 
    {
        instance_destroy();
    }
}