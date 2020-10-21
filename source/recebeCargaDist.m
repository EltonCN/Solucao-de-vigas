source cargaDistribuida.m

#Recebe cargas distribuídas dadas pelo usuário
#@param cargaDist - Vetor de cargas já existentes
#@return Vetor com as novas cargas
function retval = recebeCargaDist()
  numDeCargaDist = input("Quantos cargas distribuídas teremos? \n");

  if(numDeCargaDist == 0)
    retval = [];
    return
  endif

  for i = 1: numDeCargaDist
    x = input("Qual a posição x do início da carga?")
    comprimento = input("Qual o comprimento da carga distribuída?: ");

    cargaDist(i) = novaCarga(x, comprimento);
    cargaDist(i).polinomio(4) = input("Qual o coeficiente de x³?: ");
    cargaDist(i).polinomio(3) = input("Qual o coeficiente de x²?: ");
    cargaDist(i).polinomio(2) = input("Qual o coeficiente de x?: ");
    cargaDist(i).polinomio(1) = input("Qual o coeficiente da constante?: ");
    disp(cargaDist(i).polinomio);
  endfor
  retval = cargaDist;
endfunction
