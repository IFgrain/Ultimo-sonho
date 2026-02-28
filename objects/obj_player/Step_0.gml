// A reconstrução está acontecendo, talvez dê tempo

var _right		= keyboard_check(ord("D"));
var _left		= keyboard_check(ord("A"));
var _portal		= keyboard_check_pressed(vk_shift);
var _no_chao	= place_meeting(x, y+1, obj_box);
var _pulou		= keyboard_check_pressed(vk_space);
var _pulo_solto = keyboard_check_released(vk_space); 

if (mark && tempo_de_mark > 45)
{
	
}
else
{
	
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

	else 
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


if (!_no_chao) {
	sprite_index = spr_player_jump;
} else {
	if (hspd != 0) {
		sprite_index = spr_player_run; 
	} else {
		sprite_index = spr_player;
	}
}

if (hspd != 0) {
	image_xscale = sign(hspd) * 1.5;
}


if (mark)
{
	tempo_de_mark--;
	
	if (tempo_de_mark % 10 < 5) {
		image_alpha = 0.3;
	} else {
		image_alpha = 1;
	}
	
	if (tempo_de_mark <= 0) {
		mark = false;
		image_alpha = 1;
	}
}

if (vida <= 0)
{
	game_restart();	
}


var _cam_x = camera_get_view_x(view_camera[0]);


layer_x("bg_ceu", _cam_x * 0.9);  
layer_x("bg_arvore3", _cam_x * 0.7);   
layer_x("bg_arvore2", _cam_x * 0.4);    
layer_x("bg_arvore1", _cam_x * 0.15);   