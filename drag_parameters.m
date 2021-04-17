function [Cd, area] = drag_parameters(x,y,z)
% DRAG_PARAMETER returns drag coefficient and frontal area of the capsule
% needed to compute the air drag. The function requires the coordinate of
% the capsule.
% Call format: [Cd, area] = drag_parameter(x,y,z)

R = 3.3895e6;  

h = sqrt(x^2+y^2+z^2) - R;
Cd = 0.4 + 0.9*(1-tanh((h-1000)/100));
area = 1.2 + 30*(1-tanh((h-1000)/100));

if h < 0
    Cd = NaN; area = NaN;
    disp('Error: Unable to obtain Cd and area in drag_parameter');
    disp('       Capsule below ground');
end

end % drag_parameter