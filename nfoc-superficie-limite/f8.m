function f8 = f8(epsilon2 , epsilon1 , x2 , x1 , sigmacd  )
%F8 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;

if abs(delta) < 0.0000000001 
    f8 = sigmac(epsilon1, sigmacd) * (x1 + x2) / 2;
else
    f8 = (h_i(x2, x1, epsilon2, epsilon1) * Delta_I_n(1, sigmacd, epsilon2, epsilon1) + (x2 - x1) * Delta_J_n(1, epsilon2, epsilon1, sigmacd)) / delta ^ 2;
end

end

