function rho = air_density(x,y,z)
% AIR_DENSITY returns the atmospheric air density on Mars. The function
% requires the current location of the capsule.
% Call format: rho = air_density(x,y,z)

R = 3.3895e6;  
h = sqrt(x^2+y^2+z^2) - R;
p = 0.699*exp(-9e-5*h);
if h > 7000
    T = -23.4 - 2.22e-3*h;
elseif 0 <= h && h <= 7000 
    T = -31 - 9.98e-4*h;
else
    rho = NaN;
    disp('Error: Unable to obtain T in air_density');
    disp('       Capsule below ground');
    return;
end
rho = p/(0.1921*(T+273.1));

end % air_density