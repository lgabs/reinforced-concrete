function f11 = f11(epsilon2 , epsilon1 , x2 , x1 , sigmacd  )
%F11 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;
if abs(delta) < 0.0000000001 
    f11 = sigmac(epsilon1, sigmacd) * (x1 ^ 2 + x1 * x2 + x2 ^ 2) / 3;
else
    deltax = x2 - x1;
    h = h_i(x2, x1, epsilon2, epsilon1);
    f11 = (h ^ 2 * Delta_I_n(1, sigmacd, epsilon2, epsilon1) + 2 * h * deltax * Delta_J_n(1, epsilon2, epsilon1, sigmacd) + deltax ^ 2 * Delta_J_n(2, epsilon2, epsilon1, sigmacd)) / delta ^ 3;
end 

end

