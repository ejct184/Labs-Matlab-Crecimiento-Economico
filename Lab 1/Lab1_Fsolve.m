%% Lab 1: Numerical solutions with fsolve

clc; clear; close all;

%% Example system:
%   eq1: x^2 + y^2 = 4 -> x^2 + y^2 -4 =0
%   eq2: exp(x) + y = 1 -> exp(x) + y - 1 = 0

F = @(x) [x(1)^2 + x(2)^2 - 4; ...
               exp(x(1)) + x(2) - 1];

x0 = [0; 0];
opts = optimoptions('fsolve','Display','iter');
[sol, fval, exitflag] = fsolve(F, x0, opts);

disp('Solution found:'); disp(sol);
disp('Residuals at solution:'); disp(fval);

%% Visualization
xVals = linspace(-3,3,200);
yCircle = sqrt(4 - xVals.^2); 
yLine   = 1 - exp(xVals);

figure;
plot(xVals, yCircle,'r','LineWidth',2); hold on;
plot(xVals,-yCircle,'r','LineWidth',2);
plot(xVals, yLine,'b--','LineWidth',2);
plot(sol(1), sol(2),'ko','MarkerSize',10,'MarkerFaceColor','k');
legend('Circle (upper)','Circle (lower)','Exp','Solution');
xlabel('x'); ylabel('y'); title('System visualization');
grid on;
