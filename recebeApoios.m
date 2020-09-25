
function recebeApoios()
  numDeApoios = input("Quantos apoios teremos? (valor máximo de 10 pinos) \n");
  
  apoios = [1 , 1, 1, 1, 1, 1, 1, 1, 1, 1];
  
  for i = 1: numDeApoios
    apoios(i) = menu ("Qual o tipo de apoio?", "Engastado", "Pino", "Rolete");
  endfor
  
  apoios
  
endfunction

recebeApoios()
