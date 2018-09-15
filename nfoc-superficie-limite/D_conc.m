function D_conc = D_conc( epsilon,sigmacd )
%D_CONC Summary of this function goes here
%   Detailed explanation goes here

if epsilon < 0 || epsilon > 2 
    D_conc = 0;
else
    D_conc = sigmacd * (2 - epsilon) / 2;
end

end

