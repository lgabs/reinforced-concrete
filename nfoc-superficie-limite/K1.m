function K1 = K1( epsilon,sigmacd )

if epsilon > 0
    if epsilon < 2 
        K1 = sigmacd * epsilon ^ 4 * (15 - 2 * epsilon) / 120;
    else
        K1 = sigmacd * (5 * epsilon ^ 2 * (epsilon - 1) + 2) / 15;
    end
else
    K1 = 0;
end 


end

