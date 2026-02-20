%% Lab 1: Intro to Matlab (Code to estimate a linear regression with OLS, adding variables incrementally and plot the R2)

clear all 

% Number of observations and variables
n = 100;      % observations
p = 10;       % explanatory variables

% Simulate explanatory variables (X) and true beta coefficients
X = randn(n, p); 
true_beta = randn(p, 1);   % true coefficients
noise = randn(n, 1) * 0.5; % noise with standard deviation 0.5 -> matrix(n,k) .* 0.5 ELEMENTWISE MULTIPLICATION

% Simulate response variable (Y)
Y = X * true_beta + noise;

% Initialize arrays to store results
R2_values = zeros(p, 1); 
beta_estimates = zeros(p, p);
standard_errors = zeros(p, p);

%%
% Loop to add variables incrementally
for k = 1:p
    % Subset of X (first k variables)
    Xk = X(:, 1:k);
    
    % Add constant term (intercept)
    Xk_with_intercept = [ones(n,1), Xk];
    
    % OLS estimation: beta = (X'X)^(-1) X'Y
    beta_k = (Xk_with_intercept' * Xk_with_intercept) \ (Xk_with_intercept' * Y);
    
    % Store beta (excluding intercept)  
    beta_estimates(1:k, k) = beta_k(2:end);
    
    % Predicted Y
    Y_hat = Xk_with_intercept * beta_k;
    
    % Residuals
    residuals = Y - Y_hat;
    
    % Estimate of variance (sigma^2)
    sigma2 = sum(residuals.^2) / (n - k - 1);
    
    % Covariance matrix of beta
    cov_beta = sigma2 * inv(Xk_with_intercept' * Xk_with_intercept);
    
    % Standard errors (exclude intercept)
    se_k = sqrt(diag(cov_beta));
    standard_errors(1:k, k) = se_k(2:end);
    
    % R^2 calculation
    SS_total = sum((Y - mean(Y)).^2);
    SS_res = sum(residuals.^2);
    R2_values(k) = 1 - SS_res / SS_total;
end

%%
% Plot R^2 vs number of variables included
figure;
plot(1:p, R2_values, 'b-o', 'LineWidth', 2);
xlabel('Number of variables included');
ylabel('R^2 (Explained variance)');
title('Incremental explanatory power of regressors');
grid on;


%% 

%%%%% ------ More plots ---------- %%%%%%

% === Common plot options in MATLAB ===
%
% Colors:
%   'b' = blue
%   'r' = red
%   'g' = green
%   'k' = black
%   'm' = magenta
%   'c' = cyan
%   'y' = yellow
%
% Line styles:
%   '-'   = solid line
%   '--'  = dashed line
%   ':'   = dotted line
%   '-.'  = dash-dot line
%
% Markers:
%   'o' = circle
%   's' = square
%   'd' = diamond
%   '+' = plus sign
%   '*' = star
%   'x' = x-mark
%   '^' = upward triangle
%   'v' = downward triangle
%   '>' = right triangle
%   '<' = left triangle
%   'p' = pentagram
%   'h' = hexagram

%%
%------- Example: Compare exponential growth vs. linear growth------
close all; clear all;

x = 0:0.5:10; % secuencia de 0 a 10 by 0.5
y1 = x;        % linear
y2 = exp(0.3*x); % exponential

% 1. Multiple lines with styles and markers
figure;
plot(x, y1, 'b-o', 'LineWidth', 2, 'MarkerFaceColor','b'); hold on;
plot(x, y2, 'r-+', 'LineWidth', 2, 'MarkerFaceColor','r');
hold off;

title('Linear vs Exponential Growth');
xlabel('x');
ylabel('Value');
legend({'y = x','y = exp(0.3x)'}, 'Location','SouthWest');
grid on;

% 2. Axis customization
xlim([0 10]);
ylim([0 max(y2)+2]);
xticks(0:2:10);
yticks(0:2:20);


% 3. Save the figure
saveas(gcf,'growth_comparison.png');

%%
%-------  Subplot Example----------
close all;

x = linspace(0,2*pi,100); %row vector of 100 evenly spaced points between 0 and 2π.
y = sin(x);

figure;

% Top-left
subplot(2,2,1);
plot(x,y,'b-','LineWidth',2);
title('Blue solid');

% Top-right
subplot(2,2,2);
plot(x,y,'r--','LineWidth',2);
title('Red dashed');

% Bottom-left
subplot(2,2,3);
plot(x,y,'g:o','LineWidth',1.5);
title('Green dotted + circles');

% Bottom-right
subplot(2,2,4);
plot(x,y,'k-.s','LineWidth',1.5,'MarkerFaceColor','k');
title('Black dash-dot + squares');

sgtitle('Different line styles with subplot'); % global title
