% gda09_07
% grid search example
clear all;close all;clc;

% data are in a sinple auxillary variable, x
N=100;
xmin=0;
xmax=2.0;
Dx=(xmax-xmin)/(N-1);
x = Dx*(0:N-1)';

% two model parameters
M=2;

% true model parameters
mt = [2.5, 6.0]';

% y=f(x, m1, m2);
w0=20;
dtrue=cos(w0*mt(1)*x)+mt(1)*mt(2);

%with noise
%sd=0.4;
%dobs = dtrue + random('Normal',0,sd,N,1);

% plot data
figure(1);
clf;
set(gca,'LineWidth',2);
hold on;
axis( [0, xmax, 10, 20 ] );
plot(x,dtrue,'k-','LineWidth',3);

%with noise
%plot(x,dobs,'ko','LineWidth',2);

xlabel('x');
ylabel('d');


% 2D grid
L = 101;
Dm = 0.04;
m1min=1;
m2min=3;
m1a = m1min+Dm*(0:L-1)'; % m1a dari 0 2
m2a = m2min+Dm*(0:L-1)'; % m2a dari 0 2

m1max = m1a(L);
m2max = m2a(L);

% grid search, compute error, E
E = zeros(L,L);

for j = 1:L % kolom --> m1a
for k = 1:L % baris --> m2a
    dpre = cos(w0*m1a(j)*x) + m1a(j)*m2a(k); % perhitungan kedepan
    E(j,k) = sqrt((dtrue-dpre)'*(dtrue-dpre)/N); %RSME

    %with noise
    %E(j,k) = sqrt((dobs-dpre)'*(dobs-dpre)/N); %RSME
    

end
end

% find the minimum value of E and the corresponding (a b) value
[Erowmins, rowindices] = min(E);
[Emin, colindex] = min(Erowmins);
rowindex = rowindices(colindex);
m1est = m1min+Dm*(rowindex-1)
m2est = m2min+Dm*(colindex-1)

% evaluate prediction and plot it
dpre = cos(w0*m1est*x) + m1est*m2est
plot(x,dpre,'r-','LineWidth',2);

%no noise
legend('Sintetik data tanpa noise','Solusi');

%with noise
%legend('Sintetik data tanpa noise','Sintetik data dengan noise','Solusi');

legend boxoff ;
set(gca,'fontsize',11);
print(gcf,'true and solution grid search','-djpeg','-r300');

figure(2);
clf;
set(gca,'LineWidth',2);
hold on;
axis( [m2min, m2max, m1min, m1max] );
axis ij;
imagesc( [m2min, m2max], [m1min, m1max], E);
colormap("turbo"); colorbar;
xlabel('m2');
ylabel('m1');
plot( m2est, m1est, 'wo', 'LineWidth', 2 );
plot( mt(2), mt(1), 'go', 'LineWidth', 2 );
    
legend boxoff ;
set(gca,'fontsize',11);
legend('Estimated model','True model');
print(gcf,'true-data','-djpeg','-r300');
