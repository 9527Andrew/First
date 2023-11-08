function y = h2o2(u)

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
% sccm = 1.25;
N = (OneAtm / pressure(gas)) * ( temperature(gas) / 273.15);
vdot = u(1) * 1.0e-6/60.0 * N;  % m^3/s  PV=nRT
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
% tme = 0.0;
% dt   = 0.1;
% 
% n = 0;
% while tme < 300
    % n = n + 1;
    % tme = tme + dt;
    advance(network, u(2));
    % tm(n) = tme;
    y(1) = massFraction(cstr,'H2');
    y(2) = massFraction(cstr,'O2');
    y(3) = massFraction(cstr,'H2O');
    y(4) = temperature(gas);
    y(5) = pressure(gas);
% end