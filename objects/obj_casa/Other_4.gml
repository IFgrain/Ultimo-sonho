
if (global.venceu_dimensao == true)
{
  
    if (instance_exists(obj_player)) {
        obj_player.x = 2784;
        obj_player.y = 655.7901;
    }
    
   
  
instance_create_depth(x, y, depth, obj_casa_2);
    
  
    instance_destroy();
}