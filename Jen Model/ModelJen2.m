function dx=ModelJen2(t,x,parameters)

dx(1) = -parameters.HSkon*x(2)*x(1)+parameters.HSkoff*x(3)...
    -parameters.kon*x(4)*x(1)+parameters.koff*x(5)-parameters.kcyc*x(1); %free gamma

dx(2) = -parameters.HSkon*x(2)*x(1)+parameters.HSkoff*x(3); %HS

dx(3) = parameters.HSkon*x(2)*x(1)-parameters.HSkoff*x(3); %gamma HS

dx(4) = -parameters.kon*x(4)*x(1)+parameters.koff*x(5)+parameters.krec*x(5); %gR

dx(5) = parameters.kon*x(4)*x(1)-parameters.koff*x(5)-parameters.kendo*x(5);%gRC

dx = dx';
