function ELU = ELU( e0,kx,ky )
%ELU Summary of this function goes here
%   Detailed explanation goes here

global x_c y_c x_s y_s
global epsilon_c epsilon_s

if kx==0 && ky==0
   if e0<2 || e0>-10
       ELU = 'OK';
   else
       ELU = 'R';
   end
   
else
   %Procurar deformações máximas e mínimas na seção 
   e_max = max(epsilon_c);
   e_min = min(epsilon_c);
   x_emax = x_c(e_max==epsilon_c);
   y_emax = y_c(e_max==epsilon_c);
   x_emin = x_c(e_min==epsilon_c);
   y_emin = y_c(e_min==epsilon_c);
   % Alguns parâmetros
   u_c = [x_emax-x_emin, y_emax - y_emin];
   if u_c(1)~=0
        phi_c = atan(u_c(2)/u_c(1));
   else phi_c = sign(u_c(2))*pi/2;
   end
   phi_k = atan(ky/kx);
   h_phi = sqrt(u_c(1)^2+u_c(2)^2)*abs(sin(phi_k-phi_c));
   
   %Procurar barra com menor deformação
   e_smin = min(epsilon_s);
   k=1;
   while e_smin~=epsilon_s(k)
        k = k +1;
   end
   x_smin = x_s(k);
   y_smin = y_s(k);
   u_s =[x_emax-x_smin,y_emax-y_smin];
   if u_s(1)
        phi_s = atan(u_s(2)/u_s(1));
   else printf('a barra está em um vértice ?!');
   end
   d1 = sqrt(u_s(1)^2+u_s(2)^2)*abs(sin(phi_k-phi_s));
   beta1 = d1/h_phi;
    
   % Transformando para o terno e_c,phi,teta
   e_c = e_max;
   teta = sqrt(kx^2+ky^2)*h_phi;
   phi = phi_k + pi;
   
   % finalmente, avaliar o ELU
   if e_c>=-10 && e_c<=2
        if teta >= 0 && teta <= (10+e_c)/beta1
            ELU = 'OK';
        end
   elseif e_c >= 2 && e_c <= 7/2 
       if teta >= 7*(e_c-2)/3 && teta <= (10+e_c)/beta1
            ELU = 'OK';
       end
   else
       ELU = 'R';
   end
   
end


end

