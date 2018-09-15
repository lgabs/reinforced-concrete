function f5 = f5(x2, x1, epsilon2, epsilon1, ky, sigmacd )
%F_5 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;

if abs(delta) < 0.0000000001
    f5 = f4(x2, x1, epsilon2, epsilon1, sigmacd) - I_n(2, epsilon1, sigmacd) / ky;
else
    f5 = f4(x2, x1, epsilon2, epsilon1, sigmacd) - (1 / ky) * Delta_I_n(3, sigmacd, epsilon2, epsilon1) / delta;
end 

end

