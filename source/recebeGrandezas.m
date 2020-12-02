source grandeza.m


#Recebe grandezas dadas pelo usuário
#@param grandezas - Vetor de grandezas já existentes
#@return Vetor com as novas grandezas
function retval = recebeGrandezas()
  numDeGrandezas = input("Quantas grandezas teremos? Total de forças não distribuídas, momentos e torques?: \n");

  if(numDeGrandezas == 0)
    retval = [];
    return
  endif


  for i = 1: numDeGrandezas
    
    x = input("Qual a posicao x da grandeza?: ");
    y = input("Qual a posicao y da grandeza?: ");

    grandezas(i) = novaGrandeza(x, y);

    tipo = input("A grandeza eh um momento? Sim = 1, Nao = 0: ");
    grandezas(i).tipo = tipo;

    eixo = input("Qual o eixo da grandeza? x = 1, y = 2, z = 3: ");

    grandezas(i).magnitude = input("Qual a magnitude da grandeza (utilize valor negativo para indicar uma orientacao contraria ao eixo)?: ");

    if(grandezas(i).tipo)
      eixo += 3;
    endif

    
    grandezas(i).coeficiente(eixo) = 1;
  endfor
  
  retval = grandezas;
endfunction