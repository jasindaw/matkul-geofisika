% 1) Variasikan model bawah permukaan (Tipe model G, D, A, Q, K, H) untuk mendapatkan data Mt1D. Lantas, analisa hasil tersebut.
% 2) Untuk tipe K, variasikan resistivitas pada lapisan ke-2 dengan nilai resistivitas 1 k Ohm, 2 k Ohm, 3k Ohm dan 10 kOhm. Analisa hasil tersebut, kenapa bisa demikian?

% Bat algorithm for VES Data Inversion
clc; close all;
clear all;

%Model  sintetik
%memvariasikan model
%Variasi tipe K
tipeK1=[175 1000 100];
tipeK2=[175 2000 100];
tipeK3=[175 3000 100];
tipeK4=[175 10000 100];

%R = 1:3; %ubah resistivitas
thk = [750 1500]; %ubah ketebalan (thickness dari lapisan)
freq = logspace(-6,6,50); %ubah frekuensi
nlayer = 1:3; %mengeset banyaknya lapisan
T = 1./freq; %frekuensi

%panggil fungsi MT
[appResisK1, phaseK1] = modelMT(tipeK1, thk ,T);
[appResisK2, phaseK2] = modelMT(tipeK2, thk ,T);
[appResisK3, phaseK3] = modelMT(tipeK3, thk ,T);
[appResisK4, phaseK4] = modelMT(tipeK4, thk ,T);

%Persiapan Ploting
thk_plot = [0 cumsum(thk) max(thk)*10000];

    %Plotting
    figure(1)
    subplot(2, 2, 1)
  
    loglog(T,appResisK1,'*g','MarkerSize',12,'LineWidth',1.5);
    hold on
    loglog(T,appResisK2,'k+','MarkerSize',10,'LineWidth',1.5);
    loglog(T,appResisK3,'.b','MarkerSize',12,'LineWidth',1.5);
    loglog(T,appResisK4,'ro','MarkerSize',8,'LineWidth',1);
    
    legend('variasi rho 1k','variasi rho 2k','variasi rho 3k', 'variasi rho 10k')
    axis([10^-3 10^3 1 10^3]);
    xlabel('Periods (s)','FontSize',12,'FontWeight','Bold');
    ylabel('App. Resistivity (Ohm.m)','FontSize',12,'FontWeight','Bold');
    title('\bf \fontsize{10}\fontname{Times}Period (s) vs Apparent Resistivity (ohm.m)');
    
    grid on
    
    subplot(2, 2, 3)
    loglog(T,phaseK1,'*g','MarkerSize',12,'LineWidth',1.5);
    hold on
    loglog(T,phaseK2,'k+','MarkerSize',10,'LineWidth',1.5);
    loglog(T,phaseK3,'.b','MarkerSize',12,'LineWidth',1.5);
    loglog(T,phaseK4,'ro','MarkerSize',8,'LineWidth',1);
    
    legend('variasi rho 1k','variasi rho 2k','variasi rho 3k', 'variasi rho 10k')
    axis([10^-3 10^3 0 90]);
    set(gca, 'YScale', 'linear');
    xlabel('Periods (s)','FontSize',12,'FontWeight','Bold');
    ylabel('Phase (deg)','FontSize',12,'FontWeight','Bold');
    title('\bf \fontsize{10}\fontname{Times}Period (s) vs Phase (deg)');
    grid on
    
    subplot(2, 2, [2 4])
    stairs([0 tipeK1],thk_plot,'--g','Linewidth',5);
    hold on
    stairs([0 tipeK2],thk_plot,'--k','Linewidth',4);
    stairs([0 tipeK3],thk_plot,'--b','Linewidth',3);
    stairs([0 tipeK4],thk_plot,'--r','Linewidth',2.5);
    
%      legend({'Synthetic Model','Calculated Model'},'EdgeColor','none','Color','none','FontWeight','Bold','Location','SouthWest');
    legend('variasi rho 1k','variasi rho 2k','variasi rho 3k', 'variasi rho 10k')
    axis([1 10^4 0 5000]);
    xlabel('Resistivity (Ohm.m)','FontSize',12,'FontWeight','Bold');
    ylabel('Depth (m)','FontSize',12,'FontWeight','Bold');
    title('\bf \fontsize{10}\fontname{Times}Model');
    set(gca,'YDir','Reverse');
    set(gca, 'XScale', 'log');
    set(gcf, 'Position', get(0, 'Screensize'));
  
