function f3 = f3( y2 , y1 , epsilon2 , epsilon1 , kx , sigmacd )
%F3 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;

if abs(delta) < 0.0000000001
    f3 = f2(y2, y1, epsilon2, epsilon1, sigmacd) + I_n(2, epsilon1, sigmacd) / kx;
else
    f3 = f2(y2, y1, epsilon2, epsilon1, sigmacd) + (1 / kx) * Delta_I_n(3, sigmacd, epsilon2, epsilon1) / delta;
end
    

end

