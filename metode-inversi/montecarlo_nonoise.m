clc; clear all; close all;
% model awal acak dan fungsi objektifnya
N=200;
xmin=0;
xmax=2;
Dx=(xmax-xmin)/(N-1);
x = Dx*(0:N-1)';

% two model parameters
M=2;

% true model parameters
mt = [2.5, 6]';

% y=f(x, m1, m2);
w0=20;
dtrue = cos(w0*mt(1)*x) + mt(1)*mt(2);

%with noise
%sd=0.3;
%dobs = dtrue + random('Normal',0,sd,N,1);

%figure(4)
%clf;
%set(gca,'LineWidth',2);
%hold on;
%axis([0,xmax,15,25]);
%plot(x,dtrue,'k-','LineWidth',3);



L = 101;
Dm = 0.02;
m1min=1;
m2min=4.5;
m1a = m1min+Dm*(0:L-1)'; % m1a dari 0 2
m2a = m2min+Dm*(0:L-1)'; % m2a dari 0 2
m1max = m1a(L);
m2max = m2a(L);

% grid search, compute error, E
E = zeros(L,L);

for j = 1:L % kolom --> m1a
for k = 1:L % baris --> m2a
    dpre = cos(w0*m1a(j)*x) + m1a(j)*m2a(k); % perhitungan kedepan
    %no noise
    E(j,k) = sqrt((dtrue-dpre)'*(dtrue-dpre)/N); %RSME
    %with noise
    %E(j,k) = sqrt((dobs-dpre)'*(dobs-dpre)/N); %RSME

end
end

%plot(x,dpre,'r-','LineWidth',2);
%xlabel('x');
%ylabel('d');

%no noise
%legend('Sintetik data tanpa noise','Solusi');

%with noise
%legend('Sintetik data tanpa noise','Sintetik data dengan noise','Solusi');

%legend boxoff ;
%set(gca,'fontsize',11);
%print(gcf,'true and solution','-djpeg','-r300');

% plot data
figure(1);
clf;
set(gca,'LineWidth',2);
hold on;
axis( [m2min, m2max, m1min, m1max] );
axis ij;
imagesc([m2min, m2max], [m1min, m1max], E)
colormap("jet"); colorbar;

xlabel('m2');
ylabel('m1');
plot(mt(2), mt(1), 'go', 'LineWidth',2)

mg=[1,1]'; 
dg =cos(w0*mg(1)*x) + mg(1)*mg(2); 

%no noise
Eg =sqrt( (dtrue-dg)'*(dtrue-dg)/N);
%with noise
%Eg =sqrt( (dobs-dg)'*(dobs-dg)/N);


%%%%%%%%
%dipake g gtw jg ditulis aj dh
% plot data
plot(mg(1),mg(2),'ko','LineWidth',3);

%xlabel('x');
%ylabel('d');
%%%%%%%%%


Niter=100;
Ehis=zeros(Niter+1,1);
m1his=zeros(Niter+1,1);
m2his=zeros(Niter+1,1);
Ehis(1)=Eg;
m1his(1)=mg(1);
m2his(2)=mg(2);

% randomly generate pairs of model parameters and check % if they further minimize the error 
ma=zeros(2,1); 
for k = 1:Niter

% randomly generate a solution 
ma(1) =random('unif',m1min,m1max); 
ma(2) =random('unif',m2min,m2max);

% compute its error 
da =cos(w0*ma(1)*x) + ma(1)*ma(2); 

%no noise
Ea=sqrt((dtrue-da)'*(dtrue-da)/N);
%with noise
%Ea=sqrt((dobs-da)'*(dobs-da)/N);

% adopt it if it is better 
if( Ea < Eg )

mg=ma;
Eg=Ea 
end

%save history
Ehis(1+k)=Eg;
m1his(1+k)=mg(1);
m2his(1+k)=mg(2);

h1=plot(mg(2), mg(1), 'wo', 'LineWidth',2);
plot([m2his(1+k-1), m2his(1+k)], [m1his(1+k-1), m1his(1+k)],'r','LineWidth',2)

end

%final model
m1est=m1his(Niter+1)
m2est=m2his(Niter+1)

h2=plot(mt(2),mt(1),'go','LineWidth',3);
legend([h1, h2],'Estimated model','True model');
legend boxoff ;
set(gca,'fontsize',11);
print(gcf,'Cluster','-djpeg','-r300');

figure(2);
clf;
subplot(3,1,1);
set(gca, 'FontSize', 11)
hold on;

plot(0:Niter, Ehis, 'k-', 'LineWidth',2);
xlabel('iteration');
ylabel('RMSE');
set(gca,'Fontsize',11);
subplot(3,1,2);
set(gca, 'LineWidth',2)
hold on;

plot([0,Niter], [mt(1), mt(1)], 'r', 'LineWidth',2);
plot(0:Niter, m1his, 'k-', 'LineWidth',2);
xlabel('iteration');
ylabel('m1');
set(gca, 'FontSize',11);
subplot(3,1,3);
set(gca, 'LineWidth',2)
hold on;

plot([0,Niter], [mt(2), mt(2)], 'r', 'LineWidth',2);
plot(0:Niter, m2his, 'k-', 'LineWidth',2);
xlabel('iteration');
ylabel('m2');
set(gca, 'FontSize',11);
print(gcf,'iterasi dan model-mc', '-djpeg', '-r300')
legend('True model','Estimated model');
hold on;

% evaluate prediction and plot it
figure(3)
clf;
set(gca,'LineWidth',2);
hold on;
axis( [0, xmax, 10, 20 ] );
%plot data

plot(x,dtrue, 'k-', 'LineWidth',2)
dpre = cos(w0*m1est*x) + m1est*m2est
plot(x,dpre,'r-','LineWidth',2);

xlabel('x');
ylabel('d');

%no noise
legend('Sintetik data tanpa noise','Solusi');

%with noise
%legend('Sintetik data tanpa noise','Sintetik data dengan noise','Solusi');

legend boxoff ;
set(gca,'fontsize',11);
print(gcf,'true and solution','-djpeg','-r300');
