% 1) Variasikan model bawah permukaan (Tipe model G, D, A, Q, K, H) untuk mendapatkan data Mt1D. Lantas, analisa hasil tersebut.
% 2) Untuk tipe K, variasikan resistivitas pada lapisan ke-2 dengan nilai resistivitas 1 k Ohm, 2 k Ohm, 3k Ohm dan 10 kOhm. Analisa hasil tersebut, kenapa bisa demikian?

% Bat algorithm for VES Data Inversion
clc; close all;
clear all;

%Model  sintetik
%memvariasikan Resistivitas model
tipeH=[300 10 1000];
tipeK=[175 4000 80];
tipeA=[70 800 7000];
tipeQ=[500 100 20];
tipeG=[10 2300 2300];
tipeD=[1000 30 30];

%Variasi tipe K
%tipeK1=[20 1000 100];
%tipeK2=[20 2000 100];
%tipeK3=[20 3000 100];
%tipeK4=[20 10000 100];

%R = tipeK; %ubah resistivitas
thk = [750 1500]; %ubah ketebalan (thickness dari lapisan)
freq = logspace(-3,3,50); %ubah frekuensi
%nlayer = length(R); %mengeset banyaknya lapisan
nlayer=1:3; %mengeset banyaknya lapisan
T = 1./freq; %frekuensi

%panggil fungsi MT
%[app_sin, phase_sin] = modelMT(R, thk ,T); %apparent resis, fase resis (dalam sin)
[appResisH, phaseH] = modelMT(tipeH, thk ,T);
[appResisK, phaseK] = modelMT(tipeK, thk ,T);
[appResisA, phaseA] = modelMT(tipeA, thk ,T);
[appResisQ, phaseQ] = modelMT(tipeQ, thk ,T);
[appResisG, phaseG] = modelMT(tipeG, thk ,T);
[appResisD, phaseD] = modelMT(tipeD, thk ,T);

%Persiapan Ploting
%rho_plot = [0 R];
thk_plot = [0 cumsum(thk) max(thk)*10000];

    %Plotting
    figure(1)
    subplot(2, 2, 1)
  
    loglog(T,appResisH,'*b','MarkerSize',5,'LineWidth',1);
    hold on
    loglog(T,appResisK,'k+','MarkerSize',5,'LineWidth',1);
    loglog(T,appResisA,'.m','MarkerSize',12,'LineWidth',1.5);
    loglog(T,appResisQ,'--r','MarkerSize',12,'LineWidth',1.5);
    loglog(T,appResisG,'go','MarkerSize',5,'LineWidth',1);
    loglog(T,appResisD,'yo--','MarkerSize',5,'LineWidth',1);

%    loglog(T,app_sin,'.b','MarkerSize',12,'LineWidth',1.5);
    
    legend('tipe H','tipe K','tipe A', 'tipe Q','tipe G', 'tipe D')
    axis([10^-3 10^3 1 10^3]);
    xlabel('Periods (s)','FontSize',12,'FontWeight','Bold');
    ylabel('App. Resistivity (Ohm.m)','FontSize',12,'FontWeight','Bold');
    title('\bf \fontsize{10}\fontname{Times}Period (s) vs Apparent Resistivity (ohm.m)');
    
    grid on
    
    subplot(2, 2, 3)
    loglog(T,phaseH,'*b','MarkerSize',5,'LineWidth',1);
    hold on
    loglog(T,phaseK,'k+','MarkerSize',5,'LineWidth',1);
    loglog(T,phaseA,'.m','MarkerSize',12,'LineWidth',1.5);
    loglog(T,phaseQ,'--r','MarkerSize',12,'LineWidth',1.5);
    loglog(T,phaseG,'go','MarkerSize',5,'LineWidth',1);
    loglog(T,phaseD,'yo--','MarkerSize',5,'LineWidth',1);

%    loglog(T,phase_sin,'.b','MarkerSize',12,'LineWidth',1.5);
    
    legend('tipe H','tipe K','tipe A', 'tipe Q','tipe G', 'tipe D')
    axis([10^-3 10^3 0 90]);
    set(gca, 'YScale', 'linear');
    xlabel('Periods (s)','FontSize',12,'FontWeight','Bold');
    ylabel('Phase (deg)','FontSize',12,'FontWeight','Bold');
    title('\bf \fontsize{10}\fontname{Times}Period (s) vs Phase (deg)');
    grid on
    
    subplot(2, 2, [2 4])
%    stairs(rho_plot,thk_plot,'--g','Linewidth',5);
%    hold on
    
    stairs([0 tipeH],thk_plot,'--b','Linewidth',3);
    hold on
    stairs([0 tipeK],thk_plot,'--k','Linewidth',3);
    stairs([0 tipeA],thk_plot,'--m','Linewidth',3);
    stairs([0 tipeQ],thk_plot,'--r','Linewidth',3);
    stairs([0 tipeG],thk_plot,'--g','Linewidth',3);
    stairs([0 tipeD],thk_plot,'--y','Linewidth',3);
    
%      legend({'Synthetic Model','Calculated Model'},'EdgeColor','none','Color','none','FontWeight','Bold','Location','SouthWest');
    legend('tipe H','tipe K','tipe A', 'tipe Q', 'tipe G', 'tipe D')
    axis([1 10^4 0 5000]);
    xlabel('Resistivity (Ohm.m)','FontSize',12,'FontWeight','Bold');
    ylabel('Depth (m)','FontSize',12,'FontWeight','Bold');
    title('\bf \fontsize{10}\fontname{Times}Model');
    set(gca,'YDir','Reverse');
    set(gca, 'XScale', 'log');
    set(gcf, 'Position', get(0, 'Screensize'));
  
