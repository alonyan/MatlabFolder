function dx=ModelJen3(t,x,parameters)

dx(1) = -parameters.HSkon*x(2)*x(1)+parameters.HSkoff*x(3)-parameters.kcyc*x(1); %free gamma

dx(2) = -parameters.HSkon*x(2)*x(1)+parameters.HSkoff*x(3); %HS

dx(3) = parameters.HSkon*x(2)*x(1)-parameters.HSkoff*x(3); %gamma HS


dx = dx';