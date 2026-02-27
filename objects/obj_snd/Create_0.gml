global.vol_sfx	  = 1;
global.vol_music  = 1;
global.vol_master = 1;

audio_controller = new Audio_controller("vol_sfx", "vol_music", "vol_master");

sfx_dash = new AudioPlaySingle(snd_dash, au_typer_sfx);

