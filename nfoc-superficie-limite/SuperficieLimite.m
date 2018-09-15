function C = SuperficieLimite(L)
% omega é uma matriz nx3 contendo valores de N, Mdx, Mdy em 
% cada coluna, que compreendem um cubo com arestas 2L.
% O programa irá fazer iterações para cada terno (N, Mdx, Mdy)
% para verificar se a seção dada resiste (inclunido o ELU) a tais esforços 
% e, se a mesma resistir, guardamos os valores das deformações (e_0,kx,ky)
% associadas aos esforços, definindo assim ternos que são resistidos e ternos que não o
% são. Assim, ao final teremos um conjunto C contido em omega associado ao
% envelope de esforços resistidos pela seção. O objetivo é plotar os
% pontos desse conjunto, a fim de verificar propriedades topológicas do
% mesmo.

% medidas em MN e m

% Variáveis globais
global x_c y_c x_s y_s p_i N M 
global sigmacd fyd epsilon_yd e0 kx ky
global iteracoes

% Dados da Seção e Armadura
% -------- CONCRETO -----------
% Inseridos pelo usuário:
% x_c = [-0.5 0.5 0.5 -0.5 -0.5]; % N Vértices; vetor de N+1 com o último repetido; antihorário
% y_c = [-0.5 -0.5 0.5 0.5 -0.5];
x_c = [51 71 71 122 122   0  0 51 51]/100;
y_c = [ 0  0 82  94 103 103 94 82  0]/100;

fck = 20; % Mpa
% Cálculos
gamma_c = 1.5; %usual 1.4
sigmacd = 0.85*fck/gamma_c;
N = length(x_c)-1;
%--------------- começo: Centralização no CG da área bruta de concreto
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
    soma2y(i) = y_c(i) ^ 2 + y_c(i) * y_c(i + 1) + y_c(i + 1) ^ 2;
    soma3(i) =   x_c(i) * y_c(i + 1) + 2 * (x_c(i) * y_c(i) + x_c(i + 1) * y_c(i + 1)) + x_c(i + 1) * y_c(i);
end
A = 0.5*sum(a_i); % área da seção bruta
Sx = 1/6*sum(a_i.*soma_x);
Sy = 1/6*sum(a_i.*soma_y);
CG_c = [Sx/A, Sy/A];
x_c = x_c - CG_c(1)*ones(1,N+1);
y_c = y_c - CG_c(2)*ones(1,N+1);
%--------------- fim : Centralização no CG da área bruta de concreto
% -------- ARMADURA -----------
% Inseridos pelo usuário
x_s =[61 61 61 61 61]/100;
y_s =[13 27 41 55 69]/100;
fyk = 500; % Mpa
% Cálculos
gamma_s = 1.15;
fyd = fyk/gamma_s;
Es = 200000; % Mpa, 210000 usual
epsilon_yd = 1000*fyd/Es;
M = length(x_s); % número de barras
x_s = x_s - CG_c(1)*ones(1,M);    % centraliza no CG do concreto
y_s = y_s - CG_c(2)*ones(1,M);
p_i = 1/M*ones(1,M);
A_s = M*pi*20^2/4*1e-6;
% -----------------------------

% Corpo do Programa
% criar omega
n = 200; % número de divisões, dá origem a n^3 ternos.
omega = zeros(n,3);
omega(1,:) = 0;
for i=1:n/2 
omega(i,:) = 2*L/n*i;
omega(n/2+i,:) = - 2*L/n*i;
end
% Rodar verificações e guardar aquelas que são resistidas
C = zeros(n^3,3);
p = 1;
for i=1:n %N, coluna 1
   for j=1:n %Mdx, coluna 2
      for k=1:n %Mdy, coluna 3
          situacao = Verificar_Secao(omega(i,1),omega(j,2),omega(k,3),A_s);
          if  strcmp(situacao,'OK')
             C(p,:) = [omega(i,1) omega(j,2) omega(k,3)];
             p = p+1;
          end
      end
   end
end

scatter3(C(1:p,1),C(1:p,2),C(1:p,3))
xlabel('N (MN)');
ylabel('Mdx (MN.m)');
zlabel('Mdy (MN.M)');
fprintf('Número de pontos obtidos: %.1f\n',p-1)

end

