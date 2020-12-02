source apoio.m

#Recebe um apoio dado pelo usuário
#@param apoios - Vetor de apoios já existentes
#@return Vetor com apoios lidos
function retval = recebeApoios()
  numDeApoios = input("Quantos apoios teremos? \n");
  
  for i = 1: numDeApoios
    
    tipo = input("Qual o tipo do apoio (1 = movel/rolete, 2 = fixo/pino, 3 = engastado)?: ");
    x = input("Qual a posiçao x?: ");
    y = input("Qual a posicao y?: ");

    apoios(i) = novoApoio(x,y,tipo);
    apoios(i).theta = input("qual a orientacao do apoio?: ");
  endfor
  retval = apoios;
endfunction
