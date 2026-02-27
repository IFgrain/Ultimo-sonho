if (!mark)
{
    vida -= 1;

    // Resolve a direção
    var dir_dano = sign(x - other.x);
    if (dir_dano == 0) dir_dano = 1; // Evita bug se estiverem exatamente no mesmo pixel

    // Toma lapada horizontal E VERTICAL
    hspd = dir_dano * 6; 
    vspd = -4; // Joga o player um pouco para o alto!

    // liga invencibilidade
    mark = true;
    tempo_de_mark = 60;
}