function Alfa = Alfa(epsilon,ep_yd )
%ALFA Summary of this function goes here
%   Detailed explanation goes here

if epsilon < -ep_yd 
    Alfa = -1;
elseif epsilon > ep_yd 
    Alfa = 1;
elseif abs(epsilon) <= ep_yd 
    Alfa = epsilon / ep_yd;
end 

end

