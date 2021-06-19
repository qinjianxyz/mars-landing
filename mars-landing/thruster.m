function [Xthrust, Ythrust, Zthrust] = thruster(t, u, v, w)
% THRUSTER produces the thrust needed to slow down the capsule.
% Inputs are start and end times (tstart, tend), the maximum thrust
% produced (maxthrust), current time (t), and current velocity components
% (u,v,w).
% Call format: [Xthrust, Ythrust, Zthrust] = thruster(tstart, tend, maxthrust, t, u, v, w)

tstart = 22300;
tend = 24980;
maxthrust = -50;
period = tend - tstart;
tpeak = tstart + 0.5*period;
if t > tstart && t < tend
    Xthrust = maxthrust*exp(-((t-tpeak)/(0.25*period))^4) ...
                        *u/sqrt(u^2+v^2+w^2);
    Ythrust = maxthrust*exp(-((t-tpeak)/(0.25*period))^4) ...
                        *v/sqrt(u^2+v^2+w^2);
    Zthrust = maxthrust*exp(-((t-tpeak)/(0.25*period))^4) ...
                        *w/sqrt(u^2+v^2+w^2);    
else
    Xthrust = 0;
    Ythrust = 0;
    Zthrust = 0;
end

end % function thruster