function f6 = f6(epsilon2,epsilon1,sigmacd )
%F6 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2-epsilon1;
if abs(delta) < 0.0000000001 
    f6 = sigmac(epsilon1, sigmacd);
else
    f6 = Delta_I_n(1, sigmacd, epsilon2, epsilon1) / delta;
end


end

