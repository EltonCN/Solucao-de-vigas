classdef Forca
  
  properties
    DistanciaOrigem = 0;
    ComponenteX = 0;
    ComponenteY = 0;
    Nome = 'teste';
  endproperties
  
  methods
    
    function obj = setDistanciaOrigem(obj, distancia)
      obj.DistanciaOrigem = distancia;
    endfunction
  
    function obj = setComponenteX(obj, x)
      obj.ComponeteX = x;
    endfunction
    
    function obj = setComponenteY(obj, y)
      obj.ComponeteY = y;
    endfunction
    
    function obj = setNome(obj, nome)
      obj.Nome = nome;
    endfunction
    
    function result = getDistanciaOrigem(obj)
      result = obj.DistanciaOrigem;
    endfunction
  
    function result = getComponenteX(obj)
      result = obj.ComponenteX;
    endfunction
    
    function result = getComponenteY(obj)
      result = obj.ComponenteY;
    endfunction
    
    function result = getNome(obj)
      result = obj.Nome;
    endfunction
    
  endmethods

endclassdef
