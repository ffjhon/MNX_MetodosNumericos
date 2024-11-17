clear; clc;
h=0.1;  t=0;    Q=[0;0];
N=20;
rk4(1)=0;

for i=1:N

    % Método de Euler:
    Q_euler = Q + h * F(t, Q);
    euler(i) = Q_euler(1,1);  % Guardamos el resultado del método de Euler

    k1 = F(t, Q);
    k2 = F(t+h/2, Q+h/2.*k1);
    k3 = F(t+h/2, Q+h/2.*k2);
    k4 = F(t+h, Q+h.*k3);
    Q_nueva = Q + (h/6).*(k1 + 2.*k2 + 2.*k3 + k4);
    rk4(i+1) = Q_nueva(1,1);
    analitica(i) =  (-253/65)*cos(11*t) + (121/65)*sin(11*t) - (44/5)*exp(-2*t) + (165/13)*exp(-3*t); 
    fprintf("Iteracion: %d\n", i); disp(Q_nueva);
    Q = Q_nueva;
    t = t + h;
end

hold on;
plot(euler, 'b', 'LineWidth', 2);      % Resultados de Euler
plot(rk4, 'b', 'LineWidth', 2); 
plot(analitica, 'r', 'LineWidth', 3);

function res = F(t, Q)
    res = [Q(2,1); 550*cos(11*t) - 5.*Q(2,1) - 6.*Q(1,1)];
end