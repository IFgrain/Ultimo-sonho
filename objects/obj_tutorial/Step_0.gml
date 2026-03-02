
if (keyboard_check_pressed(vk_space)) 
{
    indice++;
    
    
  if (indice >= array_length(textos)) 
    {
        global.tutorial_feito = true; 
        instance_destroy();
    }
}