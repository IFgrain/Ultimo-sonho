// Se o player estiver a encostar na casa E apertarr no "E"
if (place_meeting(x, y, obj_player) && keyboard_check_pressed(ord("E"))) {
    room_goto(rm_dimensao); 
}

// Fazendo o player parar de ficar atras da casa
depth = -x
