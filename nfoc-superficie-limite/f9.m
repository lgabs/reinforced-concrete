function f9 = f9(epsilon2 , epsilon1 , y2 , y1 , sigmacd  )
%F9 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;


if abs(delta) < 0.0000000001 
    f9 = sigmac(epsilon1, sigmacd) * (y1 ^ 2 + y1 * y2 + y2 ^ 2) / 3;
else
    deltay = y2 - y1;
    g = g_i(y2, y1, epsilon2, epsilon1);
    f9 = (g ^ 2 * Delta_I_n(1, sigmacd, epsilon2, epsilon1) + 2 * g * deltay * Delta_J_n(1, epsilon2, epsilon1, sigmacd) + deltay ^ 2 * Delta_J_n(2, epsilon2, epsilon1, sigmacd)) / delta ^ 3;
end 

end

