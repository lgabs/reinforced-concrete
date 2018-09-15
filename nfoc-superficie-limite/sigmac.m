function sigma_c = sigmac( epsilon , sigmacd  )
%SIGMAC Summary of this function goes here
%   Detailed explanation goes here

if epsilon <= 0 
        sigma_c = 0;
elseif epsilon > 0 && epsilon < 2 
        sigma_c = sigmacd * epsilon * (4 - epsilon) / 4;
elseif epsilon >= 2 
        sigma_c = sigmacd;
end

end

