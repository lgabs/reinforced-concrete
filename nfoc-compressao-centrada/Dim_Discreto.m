function [ ] = Dim_Discreto( Nd, Mdx, Mdy )
%   Dimensionamento de armadura de maneira discreta
%   1. Os esfor�os de C�LCULO devem estar em MN; MN.m 

% Vari�veis globais
global x_c y_c x_s y_s p_i N M 
global sigmacd fyd epsilon_yd e0 kx ky
global iteracoes

% Dados da Se��o e Armadura
% -------- CONCRETO -----------
% Inseridos pelo usu�rio:
x_c = [-0.5 0.5 0 -0.5]; % N V�rtices; vetor de N+1 com o �ltimo repetido; antihor�rio
y_c = [0 0 1 0];
fck = 20; % Mpa
% C�lculos
gamma_c = 1.5; %usual 1.4
sigmacd = 0.85*fck/gamma_c;
N = length(x_c)-1;
%--------------- come�o: Centraliza��o no CG da �rea bruta de concreto
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
A = 0.5*sum(a_i); % �rea da se��o bruta
Sx = 1/6*sum(a_i.*soma_x);
Sy = 1/6*sum(a_i.*soma_y);
CG_c = [Sx/A, Sy/A];
x_c = x_c - CG_c(1)*ones(1,N+1);
y_c = y_c - CG_c(2)*ones(1,N+1);
%--------------- fim : Centraliza��o no CG da �rea bruta de concreto
% -------- ARMADURA -----------
% Inseridos pelo usu�rio
x_s = [0.03 0.09 0.37 0.37 0.03 0.03 0.09];
y_s = [0.03 0.03 0.03 0.09 0.09 0.37 0.37];
fyk = 500; % Mpa
% C�lculos
gamma_s = 1.15;
fyd = fyk/gamma_s;
Es = 200000; % Mpa, 210000 usual
epsilon_yd = 1000*fyd/Es;
M = length(x_s); % n�mero de barras
x_s = x_s - CG_c(1)*ones(1,M);    % centraliza no CG do concreto
y_s = y_s - CG_c(2)*ones(1,M);
p_i = 1/M*ones(1,M); % armaduras iguais, mas d� pra generalizar!
% -----------------------------


% Lista de bitolas comerciais
bitolas = [2.4, 3.4, 3.8, 4.2, 4.6, 5, 5.5, 6, 6.3, 6.4, 7, 8, 9.5, 10, 12.5, 16, 20, 22, 25, 32, 40];

% Corpo do Programa

k = 0;
b = length(bitolas);
situacao = 'R';
while strcmp(situacao,'R') && k<=b
   k = k+1;
   A_s = M*pi*bitolas(k)^2/4*1e-6;
   situacao = Verificar_Secao(Nd,Mdx,Mdy,A_s);
end

if situacao == 'R'
   fprintf('\nNem com a �ltima bitola a se��o resiste.\n Forne�a bitolas maiores.'); 
else
   fprintf('\nBitola m�nima: %2.1f mm� \n�rea correspondente: %4.4f m�\n(e0,kx,ky) = (%4.4f,%4.4f,%4.4f)\nItera��es NR para essa bitola: %2.2d\nUnidades padr�o: MN,MN.m,MPa,o/oo\n ',bitolas(k),A_s,e0,kx,ky,iteracoes);
end


end

