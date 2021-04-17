clear;clc;close;
fid = fopen('survey.dat','r');
counter = 1;

while ~feof(fid)
    aline = fgetl(fid);
    counter = counter + 1;
    [Q1{counter},rest] = strtok(aline);
    [Q2{counter},rest] = strtok(rest);
    [Q3{counter},rest] = strtok(rest);
    [Q4{counter},rest] = strtok(rest);
    [Q5{counter},Q6{counter}] = strtok(fliplr(rest));
    Q6{counter} = fliplr(Q6{counter});
    Q5{counter} = fliplr(Q5{counter});
end

counterA = 0;
fclose(fid);
for n = 1:length(Q4)
    if Q4{n} == 'A';
        counterA = counterA + 1;
    end
end

