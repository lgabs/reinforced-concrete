function situacao = Verificar_Secao(Nd,Mdx,Mdy,A_s)
% Sub função para fazer verificação da seção com esforços dados

global x_c y_c x_s y_s p_i N M 
global sigmacd fyd epsilon_yd e0 kx ky epsilon_c epsilon_s
global iteracoes

% Setagem:
p = 1e-7; % precisão para f = 0
t = 1e-7;% tolerância para detJ
e0 = 0;
kx = 0;
ky = 0;

A_si = zeros(1,M);
for i=1:M
    A_si(i) = p_i(i)*A_s;  % Área em cada barra
end

flag = 0;       % igual a 1 para break do looping
flag2 = 0;      % flag2, flag3, flag4 são para evitar cálculos repetidos de parâmetros da seção
flag3 = 0;      % que envolvem os vértices
flag4 = 0;      % obs: tentar mudar esses parâmetros para const
iteracoes = 1;  % num de iterações

while flag == 0
    % --------------- ESFORÇO NO CONCRETO ---------------------
    for i=1: N+1
        epsilon_c(i) = e0 + ky * x_c(i) - kx * y_c(i);
    end
    % cálculo dos esforços no concreto
    if kx~=0 || ky~=0
        if flag2==0
            delta_y = zeros(1,N);
            delta_x = zeros(1,N);
            for i=1:N
               delta_y(i) = y_c(i+1)-y_c(i);
               delta_x(i) = x_c(i+1)-x_c(i);
            end
            flag2=1;
        end
        f1i = zeros(1,N);
        for i=1:N
            f1i(i) = f1(epsilon_c(i+1),epsilon_c(i),sigmacd);
        end
        if ky ~=0
            Nc = 1/ky*sum(delta_y.*f1i);
            f2i = zeros(1,N);
            f5i = zeros(1,N);
            for i=1:N
               f2i(i) = f2(y_c(i+1),y_c(i),epsilon_c(i+1),epsilon_c(i),sigmacd);
               f5i(i) = f5(x_c(i + 1), x_c(i), epsilon_c(i + 1), epsilon_c(i), ky, sigmacd);
            end
            Mcx = -1/ky*sum(delta_y.*f2i);
            Mcy =  1/ky*sum(delta_y.*f5i);
        else % ou seja, kx ~=0
            Nc = 1/kx*sum(delta_x.*f1i);
            f3i = zeros(1,N);
            f4i = zeros(1,N);
            for i=1:N
               f3i(i) = f3(y_c(i + 1), y_c(i), epsilon_c(i + 1), epsilon_c(i), kx, sigmacd);
               f4i(i) = f4(x_c(i + 1), x_c(i), epsilon_c(i + 1), epsilon_c(i), sigmacd);
            end
            Mcx = -1/kx*sum(delta_x.*f3i);
            Mcy =  1/kx*sum(delta_x.*f4i);
        end
    else     %kx=ky=0
        if flag3 ==0  %só faz uma vez
            a_i = zeros(1,N);
            soma_y = zeros(1,N);
            soma_x = zeros(1,N);
            soma2x = zeros(1,N);
            soma2y = zeros(1,N);
            soma3 = zeros(1,N);
            for i=1:N
                a_i(i) = vetor_a_i(x_c(i + 1), x_c(i), y_c(i + 1), y_c(i));
                soma_y(i) = y_c(i)+y_c(i+1);
                soma_x(i) = x_c(i) + x_c(i + 1);
                soma2x(i) =  x_c(i) ^ 2 + x_c(i) * x_c(i + 1) + x_c(i + 1) ^ 2;
                soma2y = y_c(i) ^ 2 + y_c(i) * y_c(i + 1) + y_c(i + 1) ^ 2;
                soma3 =   x_c(i) * y_c(i + 1) + 2 * (x_c(i) * y_c(i) + x_c(i + 1) * y_c(i + 1)) + x_c(i + 1) * y_c(i);
            end
            A = 0.5*sum(a_i); % área da seção bruta
            Sx = 1/6*sum(a_i.*soma_x);
            Sy = 1/6*sum(a_i.*soma_y);
            Ixx = 1/12*sum(a_i.*soma2y);
            Iyy = 1/12*sum(a_i.*soma2x);
            Ixy = 1/24*sum(a_i.*soma3);
            flag3 = 1;
        end
        sigma_c = sigmac(e0,sigmacd);
        Nc = sigma_c * A;
        Mcx = sigma_c * Sx;
        Mcy = sigma_c * Sy;
    end
    %-------------- ESFORÇO NA ARMADURA -------------------
    %Cálculo das deformações e tensões na armadura
    Alfa_s = zeros(1,M);
    for i = 1 : M
        epsilon_s(i) = e0 + ky * x_s(i) - kx * y_s(i);
        Alfa_s(i) = Alfa(epsilon_s(i),epsilon_yd);
        %Alfa_s(i) = AlfaB(epsilon_s(i),epsilon_yd);
    end
    Ns  =  fyd * sum(Alfa_s.* A_si);
    Msx = -fyd * sum(Alfa_s.* y_s.* A_si);
    Msy =  fyd * sum(Alfa_s.* x_s.* A_si);

    %---------------------------------------------
    %             ESFORÇO TOTAL DA SEÇÃO
    %----------------------------------------------
    
    N_r = Ns + Nc;
    M_rx = Msx + Mcx;
    M_ry = Msy + Mcy;
    
    %Avaliar a norma euclidiana de f
    f = sqrt((Nd - N_r) ^ 2 + (Mdx - M_rx) ^ 2 + (Mdy - M_ry) ^ 2);
    
    if f<=p
        % Avaliar ELU
        situacao = ELU(e0,kx,ky);
        flag = 1;
    else % fora da precisão
        %---------------------------------------------------------------
        %             CÁLCULO DAS RIGIDEZES DA SEÇÃO
        %---------------------------------------------------------------
         
        %------------RIGIDEZ DA ARMADURA--------------
        J_s = zeros(3,3);
        D_i = zeros(1,M);
        for i = 1:M
            D_i(i) = D_alfa(epsilon_s(i),epsilon_yd);
        end
        J_s(1,1) =  fyd*sum(D_i.*A_si);
        J_s(1,2) = -fyd*sum(D_i.*A_si.*y_s);
        J_s(2,1) =  J_s(1,2);
        J_s(1,3) =  fyd*sum(D_i.*x_s.*A_si);
        J_s(3,1) =  J_s(1,3);
        J_s(2,3) =  -fyd*sum(D_i.*x_s.*y_s.*A_si);
        J_s(3,2) =  J_s(2,3);
        J_s(2,2) =  fyd*sum(D_i.*y_s.*y_s.*A_si);
        J_s(3,3) =  fyd*sum(D_i.*x_s.*x_s.*A_si);
        
        %-----------RIGIDEZ DO CONCRETO-------------------
        J_c = zeros(3,3);
        if ky~=0 || kx~=0
            f6i=zeros(1,N);
            f7i=zeros(1,N);
            f8i=zeros(1,N);
            f9i=zeros(1,N);
            f10i=zeros(1,N);
            f11i=zeros(1,N);
            for i = 1:N
               f6i(i) = f6(epsilon_c(i+1),epsilon_c(i),sigmacd); 
               f7i(i) = f7(epsilon_c(i+1),epsilon_c(i),y_c(i+1),y_c(i),sigmacd);
               f8i(i) = f8(epsilon_c(i+1),epsilon_c(i),x_c(i+1),x_c(i),sigmacd);
               f9i(i) = f9(epsilon_c(i+1),epsilon_c(i),y_c(i+1),y_c(i),sigmacd);
               f10i(i) = f10(epsilon_c(i + 1), epsilon_c(i), y_c(i + 1), y_c(i), x_c(i + 1), x_c(i), sigmacd);
               f11i(i) = f11(epsilon_c(i+1),epsilon_c(i),x_c(i+1),x_c(i),sigmacd);
            end
            if ky~=0
                J_c(1, 1) = 1 / ky * sum(delta_y.* f6i);
                J_c(1, 2) = -1 / ky * sum(delta_y.* f7i);
                J_c(2, 1) = J_c(1, 2);
                J_c(1, 3) = 1 / ky * (-Nc + sum(delta_y.* f8i));
                J_c(3, 1) = J_c(1, 3);
                J_c(2, 2) = 1 / ky * sum(delta_y.*f9i);
                J_c(2, 3) = -1 / ky * (Mcx + sum(delta_y.* f10i));
                J_c(3, 2) = J_c(2, 3);
                J_c(3, 3) = 1 / ky * (-2 * Mcy + sum(delta_y.* f11i));
            else %kx~=0
                J_c(1, 1) = 1 / kx * sum(delta_x.* f6i);
                J_c(1, 2) = -1 / kx * (Nc + sum(delta_x.* f7i));
                J_c(2, 1) = J_c(1, 2);
                J_c(1, 3) = 1 / kx * sum(delta_x.* f8i);
                J_c(3, 1) = J_c(1, 3);
                J_c(2, 2) = 1 / kx * (-2 * Mcx + sum(delta_x.* f9i));
                J_c(2, 3) = -1 / kx * (Mcy + sum(delta_x.* f10i));
                J_c(3, 2) = J_c(2, 3);
                J_c(3, 3) = 1 / kx * sum(delta_x.* f11i);
            end
        else %kx=ky=0
            Dc = D_conc(e0, sigmacd);
            J_c(1, 1) = Dc * A;
            J_c(1, 2) = Dc * Sx;
            J_c(2, 1) = J_c(1, 2);
            J_c(1, 3) = Dc * Sy;
            J_c(3, 1) = J_c(1, 3);
            J_c(2, 2) = Dc * Ixx;
            J_c(2, 3) = Dc * -Ixy;
            J_c(3, 3) = Dc * Iyy;
            if flag4 == 0 
                t = t * J_c(1, 1) * J_c(2, 2) * J_c(3, 3);
                flag4 = 1;
            end 
        end
        
        % somar as rigidezes
        J_r = J_c + J_s;
        detJ = det(J_r);
        
        %Análise da Tolerância
        if abs(detJ) < t
           flag = 1;
           situacao = 'R';
        else
           v = J_r\[Nd-N_r;Mdx-M_rx;Mdy-M_ry];
           e0 = e0 + v(1,1);
           kx = kx + v(2,1);
           ky = ky + v(3,1);
           iteracoes = iteracoes + 1;
        end
    end
end % looping do NR

end

