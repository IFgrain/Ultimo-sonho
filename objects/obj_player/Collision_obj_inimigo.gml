if (!mark && dash_time <= 0)
{
    vida -= 1;

    // Resolve a direção
    var dir_dano = sign(x - other.x);
    if (dir_dano == 0) dir_dano = 1; // Evita bug se estiverem exatamente no mesmo pixel

    // Toma lapada horizontal E VERTICAL
    hspd = dir_dano * 6; 
    vspd = -4; 

    // liga invencibilidade
    mark = true;
    tempo_de_mark = 60;
}