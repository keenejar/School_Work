% This File is used for fatigue calculations in ME3601

% Inputs by user
%---------------


S_ut = input('Ultimate Strength in Ksi or MPa= \n \n');
S_y = input('Yield Strength in Ksi or MPa = \n \n');
d = input('Diameter in Inches or Millimeters = \n \n');
Sur_Cond = input('Imperial(1) or Metric(2)? \n \n');

%Outputs by program

S_eprime = (S_ut*0.5);

    if Sur_Cond = 1;        %if Imperial
        K_a = %%%%%%%

    elseif Sur_Cond = 2;      %if Metric
        K_a = %%%%%%%

    else 
        Sur_Cond = input('Error: Please input "1" for Imperial or "2" for Metric')


