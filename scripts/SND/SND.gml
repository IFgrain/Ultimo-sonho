#macro au_typer_sfx    "SFX"
#macro au_typer_music  "MUSIC"


function Audio_controller(_str_sfx,_str_music,_str_master) constructor
{
	global._audio_controller = self;
	list_audio = ds_list_create();
	
	global_sfx		= _str_sfx;
	global_music	= _str_music;
	global_master	= _str_master;
	
	///@method Update
	static Update = function()
	{
		vol_sfx   = variable_global_get(global_sfx)	  * variable_global_get(global_master);
		vol_music = variable_global_get(global_music) * variable_global_get(global_master);
		
		var _size = ds_list_size(list_audio);
		for (var i = 0; i < _size; i++)
		{
			list_audio[| i].Update();
		}
	}
}


function AudioElement() constructor
{
	controller = global._audio_controller;
	ds_list_add(controller.list_audio, self);
	
	
	play	 = false;
	sound_id = noone;
	type	 = noone;
	offset	 = 1;
	
	///@method Update
	static Update = function() {  }
}


function AudioPlaySingle(_sound_id, _au_typer, _offset = 1) : AudioElement() constructor
{
	sound_id = _sound_id;
	type	 = _au_typer;
	offset	 = _offset; 
	
	///@method Update
	static Update = function() { 
		
		if (play)
		{
			var _snd = audio_play_sound(sound_id, 0, false);
			
			var _level;
			if (type == au_typer_sfx) 
			{
				_level = controller.vol_sfx * offset;
			}
			else
			{
				_level = controller.vol_music * offset;
			}
			
			audio_sound_gain(_snd, _level, 0);
			play = false;
		}
	}
}

function AudioPlayLoop(_sound_id, _au_typer, _offset = 1) : AudioElement() constructor
{
	sound_id = _sound_id;
	type	 = _au_typer;
	offset	 = _offset; 
	snd_inst = noone;
	
	///@method PlayLoop
	static PlayLoop = function() {
		if (!audio_is_playing(sound_id)) {
			snd_inst = audio_play_sound(sound_id, 0, true);
			Update(); 
		}
	}
	
	///@method Stop
	static Stop = function() {
		if (audio_is_playing(sound_id)) {
			audio_stop_sound(sound_id);
		}
	}
	
	///@method Update
	static Update = function() { 
		if (audio_is_playing(sound_id)) {
			var _level;
			if (type == au_typer_sfx) {
				_level = controller.vol_sfx * offset;
			} else {
				_level = controller.vol_music * offset;
			}
			audio_sound_gain(sound_id, _level, 0);
		}
	}
} 
