// A reconstrução está finalizada

// 1. INPUTS
var _right      = false;
var _left       = false;
var _portal     = false;
var _pulou      = false;
var _pulo_solto = false; 
var _atacar     = false;

// O JOGADOR SÓ TEM O CONTROLE SE O TUTORIAL NÃO EXISTIR MAIS!
if (!instance_exists(obj_tutorial)) 
{
    _right      = keyboard_check(ord("D"));
    _left       = keyboard_check(ord("A"));
    _portal     = keyboard_check_pressed(vk_shift);
    _pulou      = keyboard_check_pressed(vk_space);
    _pulo_solto = keyboard_check_released(vk_space); 
    _atacar     = mouse_check_button_pressed(mb_left);
}


var _no_chao    = place_meeting(x, y+1, obj_box);

// 2. VERIFICAÇÃO DE VIDA E AÇÕES
if (vida > 0)
{
	// --- GATILHO DO ATAQUE ---
	if (_atacar && !atacando && pode_atacar && dash_time <= 0 && !mark)
	{
		atacando = true;
		pode_atacar = false;
		image_index = 0; 
		alarm[1] = 25; // Cooldown do ataque

		var _dir = sign(image_xscale); 
		if (_dir == 0) _dir = 1; 
		
		var _alcance = 100; 
		var _altura = 90;  
		
		var _inimigo = collision_rectangle(x, y - _altura, x + (_dir * _alcance), y + 10, obj_inimigo, false, true);
		
		if (_inimigo != noone) 
		{
			_inimigo.vida -= 1;
			_inimigo.hspd = _dir * 5; 
			_inimigo.vspd = -4;
			_inimigo.estado = "dano";
			_inimigo.timer = 20; 
			_inimigo.sprite_index = spr_inimigo_dmg; 
			
			// Treme a tela!
			instance_create_layer(0, 0, "Instances", obj_shake);

			// Toca o som de impacto
			if (instance_exists(obj_snd)) obj_snd.sfx_hit.play = true;

			// HITSTOP
			var _tempo_congelado = current_time + 40; // Congela tudo por 40 milissegundos
			while (current_time < _tempo_congelado) { 
				// O GameMaker fica preso aqui dentro lendo o vazio e a tela "trava" pro jogador!
			}
		}
	}

	// --- LÓGICA DE MOVIMENTO ---
	if (mark && tempo_de_mark > 45)
	{
		// Sofrendo knockback, não faz nada
	}
	else
	{
		// Dash
		if (_portal && dash_time <= 0)
		{
			dash_time = 25;
			var _dir = _right - _left;
			if (_dir != 0) dash_dir = _dir;
			else dash_dir = sign(image_xscale); 
			
			if (instance_exists(obj_snd)) obj_snd.sfx_dash.play = true;
		}

		if (dash_time > 0)
		{
			hspd = dash_dir * spd_dash; 
			vspd = 0;
			dash_time -= 1;
		} 
		else // Andar Normal
		{
			hspd = (_right - _left) * spd_normal;

			if (_no_chao && _pulou) {
				vspd = pulo; 
			}
		}

		if (_pulo_solto && vspd < 0) {
			vspd *= 0.5; 
		}
	}

	// --- CONTROLE DE SPRITES ---
	// O dano tem prioridade máxima!
	if (mark && tempo_de_mark > 45) 
	{
		sprite_index = spr_player_dmg; 
	}
	else if (atacando) 
	{
		if (hspd != 0) sprite_index = spr_player_dmg_axe_1; 
		else sprite_index = spr_player_dmg_axe; 
		
		if (image_index >= image_number - 1) atacando = false;
	} 
	else if (dash_time > 0) 
	{
		sprite_index = spr_player_dash; 
	}
	else 
	{
		if (!_no_chao) sprite_index = spr_player_jump;
		else if (hspd != 0) sprite_index = spr_player_run; 
		else sprite_index = spr_player;
	}

	// --- DIREÇÃO DA SPRITE ---
	// Ele só vira se estiver andando e se NÃO estiver atacando
	if (hspd != 0 && !atacando) 
	{
		image_xscale = sign(hspd) * 1.5; 
	}
}
else
{
	// 3. A LÓGICA DE MORTE (Game Over)
	hspd = 0; // Trava o movimento horizontal

	// Troca a sprite para a de morte
	if (sprite_index != spr_player_death)
	{
		sprite_index = spr_player_death;
		image_index = 0; 
		
		if (instance_exists(obj_snd)) obj_snd.sfx_derrota.play = true; 
	}

	// Finaliza a animação e vai pro menu
	if (image_index >= image_number - 1)
	{
		image_speed = 0; 
		room_goto(rm_menu); 
	}
}


// 4. FÍSICA E COLISÕES 
vspd += grv; 

if (place_meeting(x + hspd, y, obj_box)) {
    while (!place_meeting(x+ sign(hspd), y , obj_box)) { x += sign(hspd); }
    hspd = 0;
}
x += hspd; 

if (place_meeting(x, y + vspd, obj_box)) {
    while (!place_meeting(x, y + sign(vspd), obj_box)) { y += sign(vspd); }
    vspd = 0;
}
y += vspd;


// 5. EFEITOS FINAIS
if (mark)
{
	tempo_de_mark--;
	if (tempo_de_mark % 10 < 5) image_alpha = 0.3;
	else image_alpha = 1;
	
	if (tempo_de_mark <= 0) {
		mark = false;
		image_alpha = 1;
	}
}

var _cam_x = camera_get_view_x(view_camera[0]);
layer_x("bg_ceu", _cam_x * 0.9);  
layer_x("bg_arvore3", (_cam_x * 0.7) + 80);   
layer_x("bg_arvore2", (_cam_x * 0.4) + 200);    
layer_x("bg_arvore1", _cam_x * 0.15);