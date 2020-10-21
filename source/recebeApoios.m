source apoio.m

#Recebe um apoio dado pelo usuário
#@param apoios - Vetor de apoios já existentes
#@return Vetor com apoios lidos
function retval = recebeApoios()
  numDeApoios = input("Quantos apoios teremos? \n");
  
  for i = 1: numDeApoios
    
    apoios(i).tipo = input("Qual o tipo do apoio (1 = móvel/rolete, 2 = fixo/pino, 3 = engastado)?: ");
    apoios(i).theta = input("qual a orientação do apoio?: ");
    apoios(i).x = input("Qual a posição x?: ");
    apoios(i).y = input("Qual a posição y?: ");
  endfor
  retval = apoios;
endfunction
