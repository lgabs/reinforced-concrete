function D_alfa = D_alfa( epsilon, epsilon_yd )
%D_ALFA Summary of this function goes here
%   Detailed explanation goes here


if abs(epsilon) > epsilon_yd
    D_alfa = 0;
else
    D_alfa = 1 / epsilon_yd;
end

end

