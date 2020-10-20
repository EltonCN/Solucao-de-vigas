source cargaDistribuida.m

function retval = recebeCargaDist(cargaDist)
  numDecargaDist = input("Quantos cargas distribuídas teremos? \n");
  
  for i = 1: numDecargaDist
    x = input("Qual a posição x do início da carga?")
    comprimento = input("qual o comprimento da carga distribuída?: ");

    cargaDist(i) = novaCarga(x, comprimento);
    cargaDist(i).polinomio(4) = input("qual o fator de x³?: ");
    cargaDist(i).polinomio(3) = input("qual o fator de x²?: ");
    cargaDist(i).polinomio(2) = input("qual o fator de x?: ");
    cargaDist(i).polinomio(1) = input("qual o fator da constante?: ");
    disp(cargaDist(i).polinomio);
  endfor
  retval = cargaDist;
endfunction
