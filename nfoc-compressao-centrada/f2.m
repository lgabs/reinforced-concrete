function f2 = f2( y2,y1,epsilon2,epsilon1,sigmacd)

delta = epsilon2 - epsilon1;

if abs(delta) < 0.0000000001
    f2 = I_n(1, epsilon1, sigmacd) * (y1 + y2) / 2;
else
    f2 = (g_i(y2, y1, epsilon2, epsilon1) * Delta_I_n(2, sigmacd, epsilon2, epsilon1) + (y2 - y1) * Delta_K1(epsilon2, epsilon1, sigmacd)) / delta ^ 2;
end 

end

