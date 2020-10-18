function retval = cargaParaPonto(cargasDist)
  disp(length(cargasDist));
  len = length(cargasDist);
  for i = 1: len
    
    a = cargasDist{i}.func.x3
    b = cargasDist{i}.func.x2
    c = cargasDist{i}.func.x
    d = cargasDist{i}.func.c
    f = @(x) a.*x.^3.+b.*x.^2.+c.*x.+d;
 
    [q, ier, nfun, err] = quad(f, 0, cargasDist{i}.comp);
    
  endfor
  
  retval = cargasDist;
endfunction