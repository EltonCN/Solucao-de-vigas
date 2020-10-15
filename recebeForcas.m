function retval = recebeForcas(forcas)
  numDeForcas = input("Quantos forças teremos? \n");
  
  for i = 1: numDeForcas
    
    forcas{i}.nome = input("qual o titulo da força?: ");
    forcas{i}.x = input("qual a componente x da força?: ");
    forcas{i}.y = input("qual a componente y da força?: ");
    forcas{i}.dist = input("qual a distancia da origem?: ");
  endfor
  
  retval = forcas;
endfunction