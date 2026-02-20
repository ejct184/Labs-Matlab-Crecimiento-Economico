function error = func_cpo(x)

global alpha beta delta A k0 T

c = x(1,:); %2XT 2 incognitas x T periodos (ecuaciones)
k = x(2,:);

for t=1:T-1
    error(1,t) = c(t+1)-beta*(A*alpha*k(t+1)^(alpha-1)+(1-delta))*c(t);
    error(2,t) = c(t)-(A*k(t)^alpha+(1-delta)*k(t)-k(t+1));
end

error(1,T) = k(1)-k0; %k(1)=k0
error(2,T) = k(T)-k(T-1); %k(T)=k(T-1)
	
% error (1,1)= c(2)-beta*(A*alpha*k(2)^(Alpha-1)+(1-delta))*c(1);
% error (1,2) = c(3) - beta ...;
%...
% error (1,T-1)= c(T)-beta*(a*alpha*k(T)^(alpha-1)+(1-delta))*c(T);