function [T,X,Y,Z,U,V,W] = trajectory(Xo,Yo,Zo,Uo,Vo,Wo)
%the inputs are components of the initial position (Xo, Yo, Zo) and initial velocity (Uo, Vo, Wo). The outputs are quantities discussed above.
%   Call Format:[T,X,Y,Z,U,V,W] = trajectory(Xo,Yo,Zo,Uo,Vo,Wo)

dt = 0.2; %(s)
n = 1;
X(n) = Xo;
Y(n) = Yo;
Z(n) = Zo;
U(n) = Uo;
V(n) = Vo;
W(n) = Wo;
T(n) = 0;

global R M G m;

while (sqrt(X(n)^2 + Y(n)^2 + Z(n)^2 ) >= R)
density = air_density(X(n),Y(n),Z(n));
[Cd, area] = drag_parameters(X(n),Y(n),Z(n));
[Xthrust, Ythrust, Zthrust]=thruster(T(n), U(n), V(n), W(n));
U(n+1) = U(n) + ((Xthrust / m) - (G * M * X(n) / (X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2)) - Cd * density * area * U(n) * ((U(n)^2+V(n)^2 + W(n)^2)^(1/2))/(2*m))*dt;
V(n+1) = V(n) + ((Ythrust / m) - (G * M * Y(n) / (X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2)) - Cd * density * area * V(n) * ((U(n)^2+V(n)^2 + W(n)^2)^(1/2))/(2*m))*dt;
W(n+1) = W(n) + ((Zthrust / m) - (G * M * Z(n) / (X(n)^2 + Y(n)^2 + Z(n)^2)^(3/2)) - Cd * density * area * W(n) * ((U(n)^2+V(n)^2 + W(n)^2)^(1/2))/(2*m))*dt;
X(n+1) = X(n) + U(n+1)*dt;
Y(n+1) = Y(n) + V(n+1)*dt;
Z(n+1) = Z(n) + W(n+1)*dt;
T(n+1) = T(n) + dt;
n = n+1;
end

if sqrt(X(n)^2 + Y(n)^2 + Z(n)^2 ) < R
    U(end) = [];
    V(end) = [];
    W(end) = [];
    X(end) = [];
    Y(end) = [];
    Z(end) = [];
    T(end) = [];
end



end

