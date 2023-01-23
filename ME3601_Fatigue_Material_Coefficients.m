%This Script calculates K_a(Finish), K_b(Size), K_c(Load), K_d(Temp.),
%K_e(Reliablity), S_eprime(rough endurance limit)

%Then S_e(endurance/fatigue limit) is calculated based on previous information
%---------------------------------------------------------------------

%K_a
%input(s)
Units = input('Imperial(1) or Metric(2)? \n \n');
Sur_Cond = input('Ground(1) or Machined/Cold-drawn(2), hot-rolled(3), or as-forged(4)? \n \n');
S_ut = input('Ultimate Strength(ksi or MPa) = \n \n');

%Output(s)
if Units == 1 && Sur_Cond == 1          % Imperial and Ground       
    K_a = 1.21*(S_ut)^(-0.067);
elseif Units == 1 && Sur_Cond == 2      % Imperial and Machined/Cold-Drawn 
    K_a = 2*(S_ut)^(-0.217);
elseif Units == 1 && Sur_Cond == 3      % Imperial and Hot-Rolled
    K_a = 11*(S_ut)^(-0.650);
elseif Units == 1 && Sur_Cond == 4      % Imperial and As-Forged
    K_a = 12.7*(S_ut)^(-0.758);
elseif Units == 2 && Sur_Cond == 1      % Metric and Ground 
    K_a = 1.38*(S_ut)^(-0.067);
elseif Units == 2 && Sur_Cond == 2      % Metric and Machined/Cold-Drawn
    K_a = 3.04*(S_ut)^(-0.217);
elseif Units == 2 && Sur_Cond == 3      % Metric and Hot-Rolled
    K_a = 38.6*(S_ut)^(-0.650);
elseif Units == 2 && Sur_Cond == 4      % Metric and As-Forged
    K_a = 54.9*(S_ut)^(-0.758);
else 
    fprintf('Error, K_a cannot be computed based on invalid inputs. Please restart program \n \n')     
end

%K_b
%Input(s)
d = input('Diameter(in or mm) = \n \n');                              
spin = input('Is the specimen rotating(1) or NOT rotating(0)? \n \n');
Load = input('Axial loading (1), Bending(2), or Torsion(3)? \n \n');

%Output(s)
if d < 0.3 && Units == 1 || d < 7.62 && Units == 2 || Load == 1     % If diameter is too small or axially loaded, K_b = 1
    K_b = 1;                                                             
else 
        if spin == 1                                    % If specimen is rotating -> compute K_b based on d
            if d >= 0.3 && d <= 2 && Units == 1         % 0.3in <= d <= 2in and Imperial
                K_b = 0.879*(d)^(-0.107);
            elseif d > 2 && d <= 10 && Units == 1       % 2in < d <= 10in and Imperial
                K_b = 0.91*(d)^(-0.157);
            elseif d >= 7.62 && d <= 51 && Units == 2   % 7.62mm <= d <= 2mm and Metric
                K_b = 1.24*(d)^(-0.107);
            elseif d > 51 && d <= 254 && Units == 2     % 51mm < d <= 254mm and Metric
                K_b = 1.51*(d)^(-0.157);
            else
                fprintf('Error, d value too large')
            end 
        elseif spin == 0                                         % If specimen is NOT rotating -> compute d_e then K_b
            c_sec = input('Circle(1) or Rectangle(2)? \n \n');   % Ask for cross-sec shape and compute d_e
            if c_sec == 1
                d_e = 0.370*(d);
            elseif c_sec == 2
                h = input('Height of rectangle = \n \n');
                b = input('Width of rectangle = \n \n');
                d_e = 0.808*sqrt(h*b);
            else
                fprintf('Error, invalid cross-section')
            end                                                 % Compute K_b based on d_e
                if d_e >= 0.3 && d_e <= 2 && Units == 1         % 0.3in <= d <= 2in and Imperial
                    K_b = 0.879*(d_e)^(-0.107);
                elseif d_e >= 2 && d_e <= 10 && Units == 1      % 2in < d <= 10in and Imperial
                    K_b = 0.91*(d_e)^(-0.157);
                elseif d_e >= 7.62 && d_e <= 51 && Units == 2   % 7.62mm <= d <= 2mm and Metric
                    K_b = 1.24*(d_e)^(-0.107);
                elseif d_e >= 51 && d_e <= 254 && Units == 2    % 51mm < d <= 254mm and Metric
                    K_b = 1.51*(d_e)^(-0.157);
                else
                    fprintf('Error, d_e value too large')
                end 
        else
            fprintf('Error, invalid spin value given')
        end
end

%K_c
%Output(s)
if Load == 1            % Axial Loading
    K_c = 0.85;
elseif Load == 2        % Bending
    K_c = 1;
elseif Load == 3        % Torsional
    K_c = 0.59;
else
    fprintf('Error, invalid Load value given')
end

%K_d
K_d = 1;

%K_e
%Input(s)
Reliability = input('Enter reliability percentage(50, 90, 95, 99, 99.9, 99.99, or 0 for N/A) \n \n');

%Output(s)
 if Reliability <= 50
    K_e = 1;
 elseif Reliability == 90
    K_e = 0.897;
 elseif Reliability == 95
    K_e = 0.868;
 elseif Reliability == 99
    K_e = 0.814;
 elseif Reliability == 99.9
    K_e = 0.753;
 elseif Reliability == 99.99
    K_e = 0.702; 
 else
    fprintf('Error, invalid Reliablity value given')
 end

%S_eprime

%Output(s)
if S_ut <= 200 && Units == 1        %Imperial
    S_eprime = 0.5*S_ut;                                         
elseif S_ut > 200 && Units == 1                                
    S_eprime = 100;
elseif S_ut <= 1400 && Units == 2   %Metric
    S_eprime = 0.5*S_ut;
elseif S_ut > 1400 && Units == 2                                
    S_eprime = 700;
else  
    fprintf('Error, S_ut value is too large')
end

%S_e
S_e = (K_a)*(K_b)*(K_c)*(K_d)*(K_e)*(S_eprime);

%Print values
fprintf('K_a = %.3f \n', K_a)
fprintf('K_b = %.3f \n', K_b)
fprintf('K_c = %.3f \n', K_c)
fprintf('K_d = %.3f \n', K_d)
fprintf('K_e = %.3f \n', K_e)
fprintf('S_eprime = %.3f \n', S_eprime)
fprintf('Endurance/fatigue limit, S_e = %.3f \n \n', S_e)
fprintf('REMEMBER UNITS!!!')