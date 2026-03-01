// Pega a câmera atual
var _cam = view_camera[0];
var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);

// Dá um soco aleatório na posição da câmera
camera_set_view_pos(_cam, _cx + irandom_range(-forca, forca), _cy + irandom_range(-forca, forca));

tempo--;

// Quando o tempo acabar, ele se destrói e a câmera volta ao normal
if (tempo <= 0) {
    instance_destroy();
}
