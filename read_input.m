function [Xo,Yo,Zo,Uo,Vo,Wo] = read_input(inputfile,traj_id)
%inputfile is a string denoting thename of the file to be read and traj id is an integer indicating the trajectory ID number. Theoutputs are the initial position (Xo, Yo, Zo) and components of initial velocity (Uo, Vo, Wo).
%   Call Format:[Xo,Yo,Zo,Uo,Vo,Wo] = read_input(inputfile,traj_id)

DATA = importdata(inputfile);

if any(traj_id == DATA.data(:,1))
    Xo = DATA.data(traj_id,2);
    Yo = DATA.data(traj_id,3);
    Zo = DATA.data(traj_id,4);
    Uo = DATA.data(traj_id,5);
    Vo = DATA.data(traj_id,6);
    Wo = DATA.data(traj_id,7);
else
    Xo = NaN;
    Yo = NaN;
    Zo = NaN;
    Uo = NaN;
    Vo = NaN;
    Wo = NaN;
end

end

