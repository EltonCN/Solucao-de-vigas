function retval = recebeViga(viga)
 
  viga.nome = input("qual o tipo da viga?: ");
  viga.orient = input("qual a orientação da viga?: ");
  viga.tamanho = input("qual o tamanho do viga?: ");
  viga.largura = input("qual a largura da viga?: "); 
  
  retval = viga;
endfunction