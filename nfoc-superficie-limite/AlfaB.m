function AlfaB = AlfaB( epsilon,epsilon_yd )
%ALFAB Summary of this function goes here
%   Detailed explanation goes here

if abs(epsilon) > epsilon_yd + 2 
    AlfaB = sign(epsilon);
elseif 0.7 * epsilon_yd < abs(epsilon) && Abs(epsilon) < epsilon_yd + 2 
    estrela = (280 - 9 * epsilon_yd + 3 * Sqr(800 * abs(epsilon) + epsilon_yd * (9 * epsilon_yd - 560))) / 400;
    AlfaB = Sqrt(epsilon) * estrela;
elseif abs(epsilon) <= 0.7 * epsilon_yd 
    AlfaB = epsilon / epsilon_yd;
end


end

