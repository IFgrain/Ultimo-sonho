// Fazendo o inimigo

// Se o player estiver morto, o inimigo vira uma estátua!
if (instance_exists(obj_player)) {
    if (obj_player.vida <= 0) {
        image_speed = 0; // Para a animação do inimigo
        exit; // Cancela TODO o código abaixo. Ele não anda, não ataca, não cai, não pensa.
    }
}
image_speed = 1; // Garante que a animação roda normal se o player estiver vivo

// 1. Verificando o Player e Tomando Decisões
if (instance_exists(obj_player) && estado != "dano")
{
	var _dist = distance_to_object(obj_player);
	
	// Entrou no raio de soco!
	if (_dist <= dist_ataque) 
	{
		estado = "atacando";
	}
	// Saiu do soco, mas ainda tá na visão
	else if (_dist <= dist_visao)
	{
		estado = "mogador";
	}
	// Perdeu o player de vista
	else if (estado ==  "mogador" || estado == "atacando")
	{
		estado = "parado";
		timer = tempo_parado; 
	}
}

// 2. A Máquina de Estados
switch (estado)
{
	case "parado":
		hspd = 0; 
		timer--; 
		
		if (timer <= 0) {
			estado = "vigia";
			timer = 120;
			dir_vigia = choose(1, -1);
		}
	break;
	
	case "vigia":
		hspd = dir_vigia * (spd * 0.5); 
		timer--;
		 
		if (timer <= 0) {
			estado = "parado";
			timer = tempo_parado;
		}
	break;
		
	case "mogador":
		if (instance_exists(obj_player)) {
			var _dir = sign(obj_player.x - x);
			hspd = _dir * spd; 
			sprite_index = spr_inimigo; 
		}
	break;
		
	// ESTADO DE ATAQUE
	case "atacando":
		hspd = 0; // O inimigo trava no lugar para bater
		sprite_index = spr_inimigo_atk; // Toca a animação do ataque
		
		// Quando a animação chega no último frame 
		if (image_index >= image_number - 1) 
        {
            // Verifica se o player existe e se ele AINDA está no raio de ataque!
            if (instance_exists(obj_player) && distance_to_object(obj_player) <= dist_ataque) 
            {
                // Verifica se o player NÃO está com o "mark" (invulnerável após tomar dano)
                if (!obj_player.mark) 
                {
                    obj_player.vida -= 1; // Arranca 1 coração do player!
                    
                    // Ativa a invulnerabilidade e o pisca-pisca do player
                    obj_player.mark = true; 
                    obj_player.tempo_de_mark = 60; // 1 segundo de invulnerabilidade
                    
                    // Empurra o player para trás
                    var _dir = sign(obj_player.x - x);
                    if (_dir == 0) _dir = 1;
                    
                    obj_player.hspd = _dir * 4; 
                    obj_player.vspd = -3; // Joga o player um pouquinho pra cima
                    
                    // Treme a tela para mostrar que o golpe foi duro!
                    instance_create_layer(0, 0, "Instances", obj_shake);
                    
                    // Toca o som de tomar dano 
                    if (instance_exists(obj_snd)) obj_snd.sfx_hit.play = true;
                }
            }
            
			estado = "mogador"; // Acabou a braçada, volta a correr atrás do player!
		}
	break;

	// Dano
	case "dano":
		if (hspd != 0) {
			hspd = lerp(hspd, 0, 0.1); 
		}
		timer--;
		
		// O timer acabou!
		if (timer <= 0) {
			estado = "mogador"; // Fica furioso e volta a caçar
			sprite_index = spr_inimigo;
		}
	break;
}

// 3. Olhando para a direção certa
if (hspd != 0 && estado != "dano") 
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

if (vida <= 0)
{
	instance_destroy();
}

y += vspd; 
x+= hspd;
