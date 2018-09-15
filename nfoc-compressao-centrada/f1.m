function f1 = f1(epsilon2,epsilon1,sigmacd)

delta = epsilon2-epsilon1;

if abs(delta) < 0.0000000001
    f1 = I_n(1, epsilon1, sigmacd);
else
    f1 = Delta_I_n(2, sigmacd, epsilon2, epsilon1) / delta;
end 

end

