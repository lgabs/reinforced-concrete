function Delta_J_n = Delta_J_n(n , epsilon2 , epsilon1 , sigmacd)
%DELTA_J_N Summary of this function goes here
%   Detailed explanation goes here

Delta_J_n = J_n(n, epsilon2, sigmacd) - J_n(n, epsilon1, sigmacd);


end

