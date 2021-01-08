source singularidade.m

function tensaoCisalhamento = calculaTensaoCisalhamento(forcaCortante, areaSecao, raioExterno, raioInterno)

    tensaoCisalhamento = [];

    coeficiente = (4.0/3.0);

    r2 = raioExterno * raioExterno;
    r1 = raioInterno * raioInterno;
    r21 = raioExterno * raioInterno;

    coeficiente *= (r2 + r21 + r1)/(r2+r1);

    coeficiente = 1.0/coeficiente;

    for j =1:columns(forcaCortante)
        tensaoCisalhamento = [tensaoCisalhamento, divideMagnitude(forcaCortante(j), coeficiente)];
    endfor

endfunction

function tensaoNormal = calculaTensaoNormal(forcaNormal, areaSecao)

    tensaoNormal = [];

    for j = 1:columns(forcaNormal)
        tensaoNormal = [tensaoNormal, divideMagnitude(forcaNormal(j), areaSecao)];
    endfor


endfunction