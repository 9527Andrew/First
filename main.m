clear all;
close all;
clc;

gas = Solution('h2o2.yaml');

p = 60.0*133.3;
t = 770.0;

OneAtm = 1.01325e5;
set(gas,'T', 300.0, 'P', p, 'X', 'H2:2, O2:1'); 

upstream = Reservoir(gas);

%% 设置CSTR
set(gas, 'T', t, 'P', p);
cstr = IdealGasReactor(gas);
setInitialVolume(cstr, 10.0*1.0e-6);

%% 设置环境
env = Reservoir(gas);

%% 设置传热
w = Wall;
install(w, cstr, env);
setArea(w, 1.0);
setHeatTransferCoeff(w, 0.02);

%% 设置流量
sccm = 1.25;
vdot = sccm * 1.0e-6/60.0 * ((OneAtm / pressure(gas)) * ( temperature(gas) / 273.15));  % m^3/s
mdot = density(gas) * vdot;   % kg/s
mfc = MassFlowController;
install(mfc, upstream, cstr);
setMassFlowRate(mfc, mdot);

%% 设置产物
downstream = Reservoir(gas);
v = Valve;
install(v, cstr, downstream);
setValveCoeff(v, 1.0e-9);

%% 设置反应网络
network = ReactorNet({cstr});

%% 迭代
tme = 0.0;
dt   = 0.05;

n = 0;
while tme < 300
    n = n + 1;
    tme = tme + dt;
    advance(network, tme);
    tm(n) = tme;
    y(1,n) = massFraction(cstr,'H2');
    y(2,n) = massFraction(cstr,'O2');
    y(3,n) = massFraction(cstr,'H2O');
    temp(n) = temperature(gas);
    pr(n) = pressure(gas);
end

%% 画图
clf
figure(1)
plot(tm,y,'LineWidth',1.5)
legend('H2','O2','H2O')
title('Mass Fractions')

figure(2)
plot(tm,temp,'LineWidth',1.5)
legend('T')
title('Temperatures')

figure(3)
plot(tm,pr,'LineWidth',1.5)
legend('P')
title('Pressure')




