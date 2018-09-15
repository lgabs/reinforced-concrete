function J_n = J_n(n , epsilon , sigmacd )

%J_N Summary of this function goes here
%   Detailed explanation goes here

if epsilon <= 0 
    J_n = 0;
elseif epsilon > 0 && epsilon <= 2
    J_n = sigmacd * epsilon ^ (n + 2) * (4 * (n + 3) - epsilon * (n + 2)) / (4 * (n + 2) * (n + 3));
elseif epsilon > 2
    J_n = sigmacd * ((n + 2) * (n + 3) * epsilon ^ (n + 1) - 2 ^ (n + 2)) / ((n + 1) * (n + 2) * (n + 3));
end

end

