% Bruce Goldfeder
% CSI 690
% Homework 7

% Three integral functions provided
% all are evaluated from -1 to 1

clear; clc;

f1 = @(x) cosd(x)
f2 = @(x) 1./(1 + 100.*x.^2)
f3 = @(x) sqrt(abs(x))

Q1 = quad(f1,-1,1)
Q2 = quad(f2,-1,1)
Q3 = quad(f3,-1,1)

Q1 = quadgk(f1,-1,1)
Q2 = quadgk(f2,-1,1)
Q3 = quadgk(f3,-1,1)

Qad = adpsim(-1,1,1e-4,f1)

fprintf(' t f1(t) s(t)\n');
%for t = 1:1:20
 %   fprintf('%16.12g %16.12f %16.12g %16.12g\n', t, ...
 %   adpsim(-1,(t-10)./10,1e-4,f1), adpsim(-1,(t-10)./10,1e-4,f2), adpsim(-1,(t-10)./10,1e-4,f3));
%end
%P1 = zeros(40,6)
%P2 = zeros(40,6)
%P3= zeros(40,6)
for t = 1:1:20
   plot(t-10./10,adpsim((t-10)./10,((t-10)./10)+.1,1e-4,f1),'r-*');
   hold on
   %P2 = [P2,adpsim(-1,(t-10)./10,1e-4,f2)]
   %P3 = [P3,adpsim(-1,(t-10)./10,1e-4,f3)]
end

