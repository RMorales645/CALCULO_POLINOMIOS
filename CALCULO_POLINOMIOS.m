%RONALD ALEXIS MORALES VARELA
%0901-23-6114

clc; clear; close all;

p = [1 -6 11 -6]; % Coeficientes de p(x) = x^3 - 6x^2 + 11x - 6
q = [1 -1];       % Coeficientes de q(x) = x - 1

operaciones_estandar(p, q);

x_val = 2;
fprintf('\nEvaluación estándar de p(x) en x=%d: %f\n', x_val, evaluar_estandar(p, x_val));
fprintf('Evaluación anidada de p(x) en x=%d: %f\n', x_val, evaluar_anidado(p, x_val));

%% Función para normalizar polinomios al mismo tamaño
function [p_norm, q_norm] = normalizar(p, q)
    longitud_max = max(length(p), length(q));
    
    if length(p) < longitud_max
        p_norm = [zeros(1, longitud_max - length(p)), p];
    else
        p_norm = p;
    end
    
    if length(q) < longitud_max
        q_norm = [zeros(1, longitud_max - length(q)), q];
    else
        q_norm = q;
    end

    % Mensaje informativo si hubo cambios
    if length(p) ~= length(q)
        fprintf('Los polinomios no tenían el mismo tamaño y fueron normalizados.\n');
    end
end

function operaciones_estandar(p, q)
    [p_norm, q_norm] = normalizar(p, q);

    % Suma de polinomios
    suma = p_norm + q_norm;
    
    % Multiplicación de polinomios
    producto = conv(p, q);
    
    % División de polinomios
    if length(p) >= length(q)
        [cociente, residuo] = deconv(p, q);
    else
        cociente = 0;
        residuo = p; % Si (q) es de mayor grado, (p) es el residuo
    end

    % Resultados
    fprintf('\nOperaciones con los polinomios: p(x) = [%s] y q(x) = [%s]\n', ...
        char(poly2sym(p)), char(poly2sym(q)));
    fprintf('Suma: %s\n', char(poly2sym(suma)));
    fprintf('Producto: %s\n', char(poly2sym(producto)));
    
    if all(residuo == 0)
        fprintf('División: %s\n', char(poly2sym(cociente)));
    else
        fprintf('División: %s, con residuo: %s\n', char(poly2sym(cociente)), char(poly2sym(residuo)));
    end
end

%% Función para evaluar un polinomio de forma estándar (polyval)
function resultado = evaluar_estandar(p, x)
    resultado = polyval(p, x);
end

%% Función para evaluar un polinomio de forma anidada (método de Horner)
function resultado = evaluar_anidado(p, x)
    resultado = p(1);
    for i = 2:length(p)
        resultado = resultado * x + p(i);
    end
end