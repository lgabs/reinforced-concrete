function [ Nd,Mdx,Mdy ] = Majorar_Forcas(Nk,Mkx,Mky)
% Majora as a��es
gamma_F = 1.4
[ Nd,Mdx,Mdy ] = gamma_F*[ Nk,Mkx,Mky ]
end

