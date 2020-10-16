function retval = recebeApoios(apoios)
  numDeApoios = input("Quantos apoios teremos? \n");
  
  for i = 1: numDeApoios
    
    apoios{i}.nome = input("qual o tipo do apoio?: ");
    apoios{i}.orient = input("qual a orientação do apoio?: ");
    apoios{i}.dist = input("qual a distancia da origem?: ");
    
  endfor
  retval = apoios;
endfunction
