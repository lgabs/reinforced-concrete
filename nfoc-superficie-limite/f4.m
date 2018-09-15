function f4 = f4(x2 , x1 , epsilon2 , epsilon1 , sigmacd  )
%F4 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;

if abs(delta) < 0.0000000001 
    f4 = I_n(1, epsilon1, sigmacd) * (x1 + x2) / 2;
else
    f4 = (h_i(x2, x1, epsilon2, epsilon1) * Delta_I_n(2, sigmacd, epsilon2, epsilon1) + (x2 - x1) * Delta_K1(epsilon2, epsilon1, sigmacd)) / delta ^ 2;
end

end

