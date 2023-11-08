clear all;
close all;
clc;

sim('hyg.slx');

%% mass fraction
figure(1)
plot(out.ScopeData.time,out.ScopeData.signals(1).values(:,1),'LineWidth',1.5)
hold on
plot(out.ScopeData.time,out.ScopeData.signals(1).values(:,2),'LineWidth',1.5)
hold on
plot(out.ScopeData.time,out.ScopeData.signals(1).values(:,3),'LineWidth',1.5)
hold on
legend('H2','O2','H2O')
title('Mass Fractions')
set(gca,'FontName','Arial','FontSize',12)
xlabel('Time(s)')
ylabel('MassFraction')
exportgraphics(gcf,'mass fraction.pdf','ContentType','vector');
%% temp
figure(2)
plot(out.ScopeData.time,out.ScopeData.signals(2).values,'LineWidth',1.5)
hold on
legend('T')
title('Temperatures')
set(gca,'FontName','Arial','FontSize',12)
xlabel('Time(s)')
ylabel('Tempreture')
exportgraphics(gcf,'tempreture.pdf','ContentType','vector');
%%
figure(3)
plot(out.ScopeData.time,out.ScopeData.signals(3).values,'LineWidth',1.5)
hold on
legend('P')
title('Pressure')
set(gca,'FontName','Arial','FontSize',12)
xlabel('Time(s)')
ylabel('Pressure')
exportgraphics(gcf,'pressure.pdf','ContentType','vector');

%% 画图
% clf
% figure(1)
% plot(tm,y,'LineWidth',1.5)
% legend('H2','O2','H2O')
% title('Mass Fractions')
% 
% figure(2)
% plot(tm,temp,'LineWidth',1.5)
% legend('T')
% title('Temperatures')
% 
% figure(3)
% plot(tm,pr,'LineWidth',1.5)
% legend('P')
% title('Pressure')




