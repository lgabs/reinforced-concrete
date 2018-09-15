function I_n = I_n(n,epsilon,sigmacd)

if epsilon > 0
    if n == 1 
        if epsilon < 2 
            I_n = sigmacd * epsilon ^ 2 * (6 - epsilon) / 12;
        else
            I_n = sigmacd * (3 * epsilon - 2) / 3;
        end
    elseif n == 2 
        if epsilon < 2 
            I_n = sigmacd * epsilon ^ 3 * (8 - epsilon) / 48;
        else
            I_n = sigmacd * (3 * epsilon ^ 2 - 4 * epsilon + 2) / 6;
        end
    elseif n == 3 
        if epsilon < 2 
            I_n = sigmacd * epsilon ^ 4 * (10 - epsilon) / 240;
        else
            I_n = sigmacd * (5 * epsilon * (epsilon ^ 2 - 2 * epsilon + 2) - 4) / 30;
        end
    end
else
    I_n = 0;
end


end

