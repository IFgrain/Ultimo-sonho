

// Agora ele precisa estar encostando E apertar o botão de interação!
if (place_meeting(x, y, obj_player) && keyboard_check_pressed(ord("E")))
{
    room_goto(rm_final); // Agora sim, vai para a glória!
}