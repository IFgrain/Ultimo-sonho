// Fazendo o inimigo

// Verificando se o player existe
if (instance_exists(obj_player))
{
	var _dist = distance_to_object(obj_player)
	
	//	Se o player aparecer na minha visão
	if (_dist <= dist_visao)
	{
		// Eu mogo ele, ou pelo menos tento
		estado = "mogador"
	}
	// Se o player meter o pé e sair do meu campo de visão
	else if (estado ==  "mogador")
	{
		//eu paro de seguir ele e inicio a contagem do tempo parado
		estado = "parado"
		timer = tempo_parado 
	}
}

// Trocando os estados
switch (estado)
{
	case "parado":
	hspd = 0 // descansar,né? Que o cara não é de ferro
	timer--; // cotagem regressiva começa
	
	// Quando o tempo do cronometro acaba
	if (timer <= 0)
	{
		// Eu volto a andar por um tempo antes de parar de novo
	    estado = "vigia"
		timer = 120;
		dir_vigia = choose(1, -1);
	}
	break
	
	case "vigia":
	//  Quando eu estou vigiando, eu ando mais lento
	 hspd = dir_vigia * (spd * 0.5); 
     timer--;
	 
	 // Cansei caminhar, vou parar um pouquinho
        if (timer <= 0) 
        {
            estado = "parado";
            timer = tempo_parado;
        }
        break;
		
		// finalizando o loop
		 case "mogador":
        if (instance_exists(obj_player)) 
        {
            // vi o player, vou atrás dele
            var _dir = sign(obj_player.x - x);
            hspd = _dir * spd; 
        }
        break;
		
		case "dano":
        // Aqui ele NÃO tenta andar atrás do player. 
        // Ele fica apenas deslizando para trás com o hspd do knockback.
        
        // Atrito para ele ir freando no chão 
        if (hspd != 0) {
            hspd = lerp(hspd, 0, 0.1); 
        }

        timer--;
        
        // Quando o tempo de atordoamento acabar...
        if (timer <= 0) {
            estado = "mogador"; // Volta a ficar puto e vai atrás do player
            sprite_index = spr_inimigo; 
        }
    break;
}

// Olhando  para a direção que estou indo
if (hspd != 0) 
{
    image_xscale = sign(hspd);
}

// Colisão horizontal
if (place_meeting(x + hspd, y, obj_box))
{
	// Então ele puxa o inimigo pixel por pixel 
	// " "Ele" quem?" não sei
	while (!place_meeting(x+ sign(hspd), y , obj_box))    
	{
		x+= sign(hspd);
	}
	// zera a velocidade vertical/pulo quando bater no chão ou parede
	hspd = 0;
}

 vspd += grv
 
// Colisão Vertical 
if (place_meeting(x, y + vspd, obj_box))
{
	while (!place_meeting(x, y + sign(vspd), obj_box)) {
		y += sign(vspd);
	}
	vspd = 0;
}


y += vspd; 
x+= hspd;
