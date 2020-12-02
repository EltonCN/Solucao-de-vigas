source grandeza.m
source variavel.m

#Cria um novo apoio
#@param x - Posição x do apoio
#@param y - Posição y do apoio
#@param tipo - Tipo de apoio (1 = móvel/rolete, 2 = fixo/apoio, 3 = engastado)
#@return O novo apoio criado
function novoApoio = novoApoio(x, y, tipo)
    novoApoio = struct("x", x, "y", y, "z", 0, "theta", 0, "tipo", tipo, "nome", "aaa");

    switch(tipo)
        case 1
            novoApoio.nome = "móvel";
        case 2
            novoApoio.nome = "fixo";
        case 3
            novoApoio.nome = "engastado";
    endswitch

endfunction

#Retorna o vetor de variáveis de um apoio
#@param apoio - Apoio que irá gerar as variáveis
#@return Vetor com as variáveis do apoio
function variaveis = getVariavel(apoio)
    

    switch(apoio.tipo)
        case 1

            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(2) = 1 * cos(apoio.theta);
            variavel.coeficiente(1) = 1 * sin(apoio.theta);

            variavel.nome = strcat(apoio.nome, " Vertical");

            variaveis(1) = variavel;

            
        case 2
            
            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(2) = 1 * cos(apoio.theta);
            variavel.coeficiente(1) = 1 * sin(apoio.theta);
            variavel.nome = strcat(apoio.nome, " Vertical");

            variaveis(1) = variavel;
            
            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(2) = 1 * sin(apoio.theta);
            variavel.coeficiente(1) = 1 * cos(apoio.theta);
            variavel.nome = strcat(apoio.nome, " Horizontal");

            variaveis(2) = variavel;

            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(4) = 1;
            variavel.tipo = true;
            variavel.nome = strcat(apoio.nome, " Torque");

            variaveis(3) = variavel;

        case 3
            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(2) = 1 * cos(apoio.theta);
            variavel.coeficiente(1) = 1 * sin(apoio.theta);
            variavel.nome = strcat(apoio.nome, " Vertical");

            variaveis(1) = variavel;
            
            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(2) = 1 * sin(apoio.theta);
            variavel.coeficiente(1) = 1 * cos(apoio.theta);
            variavel.nome = strcat(apoio.nome, " Horizontal");

            variaveis(2) = variavel;

            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(4) = 1;
            variavel.tipo = true;
            variavel.nome = strcat(apoio.nome, " Torque");

            variaveis(3) = variavel;

            variavel = novaVariavel(apoio.x,apoio.y);
            variavel.coeficiente(6) = 1;
            variavel.tipo = true;
            variavel.nome = strcat(apoio.nome, " Momento");

            variaveis(4) = variavel;
            

    endswitch

    

endfunction

