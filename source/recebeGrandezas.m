function retval = recebeGrandezas(grandezas)
  numDeForcas = input("Quantas grandezas teremos? número de componentes de força + torque + momentos \n");
  
  for i = 1: numDeGrandezas
    
    grandezas{i}.magnitude = input("qual a magnitude da grandeza?: ");
    grandezas{i}.eixo = input("qual o eixo da grandeza? x = 1, y = 2 z = 3: ");
    grandezas{i}.ehForca = input("a grandeza é uma força?: sim = 1 não = 0 ");
    grandezas{i}.distancia = input("qual a distancia da origem?: ");
  endfor
  
  retval = grandezas;
endfunction