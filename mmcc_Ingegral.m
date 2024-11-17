%syms x
%f = x^7 + 3*x^6 - 3*x^5 + 21*x^4 - 36*x^3 + x^2 - 13*x - 3 % [-2, 1] 95763/280 = 342.011
%I = int(f,x, -2, 1)

%f = @(x) x.^7 + 3*x.^6 - 3*x.^5 + 21*x.^4 - 36*x.^3 + x.^2 - 13*x - 3

function result = Trap(h, f0, f1)
    result = h * (f0+f1)/2;
end

function result = Trapm(h, n, f)
    sum = f(1); % MATLAB uses 1-based indexing
    for i = 2:n-1
        sum = sum + 2 * f(i);
    end
    result = h * sum/2;
end

function result = Simp13(h, f0, f1, f2)
    result = (2 * h * (f0 + 4*f1 + f2)) / 6;
end

function result = Simp38(h, f0, f1, f2, f3)
    result = (3 * h * (f0 + 3*(f1 + f2) + f3)) / 8;
end

function result = Simp13m(h, n, f)
    sum = f(1); % MATLAB uses 1-based indexing
    for i = 2:2:n-2
        sum = sum + 4 * f(i) + 2 * f(i+1);
    end
    sum = sum + 4 * f(n-1) + f(n);
    result = h * sum / 3;
end

function result = Simpint(a, b, n, f)
    h = (b-a)/n;
    
    if n == 1
        result = Trap(h, f(1), f(2)); % Ajustado para MATLAB
    else
        m = n;
        odd = mod(n, 2); % Para verificar si n es impar        
        sum = 0;         % Inicializar la suma
        
        if odd > 0 && n > 1
            sum = sum + Simp38(h, f(n-3), f(n-2), f(n-1), f(n));
            m = n - 3;
        end
        
        if m > 1
            sum = sum + Simp13m(h, m, f);
        end
        
        result = sum;
    end
end

% Definimos la función
f = @(x) x.^7 + 3*x.^6 - 3*x.^5 + 21*x.^4 - 36*x.^3 + x.^2 - 13*x - 3;
valor_real = 342.011; % 95763/280 = 342.011

% Definimos el intervalo y el número de subintervalos
a = -2; % límite inferior
b =  1; % límite superior
n = 3; % número de subintervalos

% Calculamos los valores de f en los puntos de interés
x = linspace(a, b, n+1); % Genera n+1 puntos en el intervalo [a, b]
f_values = f(x);         % Calcula los valores de f en esos puntos

% Llamamos a la función Simpint
integral_result = Simpint(a, b, n, f_values);

% Mostramos el resultado
clc;
error = abs((integral_result - valor_real)/valor_real)*100;
disp(['Valor real: ', num2str(valor_real)]);
disp(['El resultado de la integración es: ', num2str(integral_result)]);
disp(['Error relativo: ', num2str(error), '%']);


% Graficar la función
figure;
hold on;

% Graficar la función
fplot(f, [a b], 'LineWidth', 2, 'DisplayName', 'f(x)');

% Resaltar el área bajo la curva
x_fill = linspace(a, b, n + 1); % Puntos en x para el área
f_fill = f(x_fill); % Calcular los valores de f para esos puntos
fill([x_fill, fliplr(x_fill)], [f_fill, zeros(1, length(f_fill))], 'r', 'FaceAlpha', 0.3);

% Etiquetas y título
xlabel('x');
ylabel('f(x)');
title('Gráfica de la función y el área bajo la curva');

% Añadir la expresión de la función como texto
text(-1.45, 750, '$f_2(x) = x^7 + 3x^6 - 3x^5 + 21x^4 - 36x^3 + x^2 - 13x - 3, x \in [-2, 1]$', ...
     'Interpreter', 'latex', 'FontSize', 14, 'Color', 'k', 'BackgroundColor', 'w', 'EdgeColor', 'k');
legend('f_2(x)', 'Área Integrada');
%legend show;
grid on;
hold off;
