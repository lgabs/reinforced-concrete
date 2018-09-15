function f7 = f7( epsilon2 , epsilon1 , y2 , y1 , sigmacd )
%F7 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;

if abs(delta) < 0.0000000001
    f7 = sigmac(epsilon1, sigmacd) * (y1 + y2) / 2;
else
    f7 = (g_i(y2, y1, epsilon2, epsilon1) * Delta_I_n(1, sigmacd, epsilon2, epsilon1) + (y2 - y1) * Delta_J_n(1, epsilon2, epsilon1, sigmacd)) / delta ^ 2;
end

end

