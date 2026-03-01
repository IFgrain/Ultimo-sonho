// A reconstrução está acontecendo e quase finalizada

// 1. INPUTS
var _right		= keyboard_check(ord("D"));
var _left		= keyboard_check(ord("A"));
var _portal		= keyboard_check_pressed(vk_shift);
var _no_chao	= place_meeting(x, y+1, obj_box);
var _pulou		= keyboard_check_pressed(vk_space);
var _pulo_solto	= keyboard_check_released(vk_space); 
var _atacar		= mouse_check_button_pressed(mb_left);


// 2. O GATILHO DO ATAQUE (A Machadada Instantânea!)
if (_atacar && !atacando && pode_atacar && dash_time <= 0 && !mark)
{
    atacando = true;
    pode_atacar = false;
    image_index = 0; 
    alarm[1] = 25; // Cooldown do ataque

    // Descobre para qual lado o player está olhando
    var _dir = sign(image_xscale); 
    if (_dir == 0) _dir = 1; 
    
    // Define o tamanho da área de acerto 
    var _alcance = 100; // Quão longe o machado alcança
    var _altura = 90;  // Altura do machado
    
    // Cria uma caixa imaginária na frente do player e procura um inimigo lá dentro
    var _inimigo = collision_rectangle(x, y - _altura, x + (_dir * _alcance), y + 10, obj_inimigo, false, true);
    
    // Se encontrou um inimigo na área do machado...
    if (_inimigo != noone) 
    {
        // Aplica dano
        _inimigo.vida -= 1;
        
        // Empurrão (Knockback)
        _inimigo.hspd = _dir * 5; 
        _inimigo.vspd = -4;
        
        // Muda o estado do inimigo para "dano" e trava a IA dele
        _inimigo.estado = "dano";
        _inimigo.timer = 20; 
        _inimigo.sprite_index = spr_inimigo_dmg; 
        
        // Treme a tela!
        instance_create_layer(0, 0, "Instances", obj_shake);
        
        // Toca o som de impacto
        if (instance_exists(obj_snd)) obj_snd.sfx_hit.play = true;
    }
}

// 3. LÓGICA DE MOVIMENTO
if (mark && tempo_de_mark > 45)
{
	// Sofrendo knockback
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

	// Pulo variável
	if (_pulo_solto && vspd < 0) {
		vspd *= 0.5; 
	}
}


// 4. FÍSICA E COLISÕES
vspd += grv; 

if (place_meeting(x + hspd, y, obj_box))
{
	while (!place_meeting(x+ sign(hspd), y , obj_box)) {
		x += sign(hspd);
	}
	hspd = 0;
}
x += hspd; 

if (place_meeting(x, y + vspd, obj_box))
{
	while (!place_meeting(x, y + sign(vspd), obj_box)) {
		y += sign(vspd);
	}
	vspd = 0;
}
y += vspd; 


// 5. CONTROLE DE SPRITES 
if (atacando) 
{
	if (hspd != 0) {
		sprite_index = spr_player_dmg_axe_1; 
	} else {
		sprite_index = spr_player_dmg_axe; 
	}
	
	// Encerra o ataque quando a animação do machado acaba
	if (image_index >= image_number - 1)
	{
		atacando = false;
	}
} 
else 
{
	if (!_no_chao) {
		sprite_index = spr_player_jump;
	} else {
		if (hspd != 0) {
			sprite_index = spr_player_run; 
		} else {
			sprite_index = spr_player;
		}
	}
}


// 6. EFEITOS FINAIS (Virar, Dano e Parallax)
if (hspd != 0) {
	image_xscale = sign(hspd) * 1.5;
}

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

if (vida <= 0) {
	game_restart();	
}

var _cam_x = camera_get_view_x(view_camera[0]);
layer_x("bg_ceu", _cam_x * 0.9);  
layer_x("bg_arvore3", _cam_x * 0.7);   
layer_x("bg_arvore2", _cam_x * 0.4);    
layer_x("bg_arvore1", _cam_x * 0.15);