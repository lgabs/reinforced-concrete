function f10 = f10( epsilon2 , epsilon1 , y2 , y1 , x2 , x1 , sigmacd )
%F10 Summary of this function goes here
%   Detailed explanation goes here

delta = epsilon2 - epsilon1;


if abs(delta) < 0.0000000001 
    f10 = sigmac(epsilon1, sigmacd) * (x1 * y2 + 2 * (x1 * y1 + x2 * y2) + x2 * y1) / 6;
else
    deltay = y2 - y1;
    deltax = x2 - x1;
    g = g_i(y2, y1, epsilon2, epsilon1);
    h = h_i(x2, x1, epsilon2, epsilon1);
    f10 = (h * g * Delta_I_n(1, sigmacd, epsilon2, epsilon1) + (g * deltax + h * deltay) * Delta_J_n(1, epsilon2, epsilon1, sigmacd) + deltax * deltay * Delta_J_n(2, epsilon2, epsilon1, sigmacd)) / delta ^ 3;
end 


end

