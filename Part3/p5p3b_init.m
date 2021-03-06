%Task 5.3 b
sim('p5p3b.mdl')
%From task 1
K=0.1561;
T=72.4347;

%Values for PD-regulator

T_d=T; %to cancel time constant of transfer function
%T_f=8.39130;
T_f=-10/tan(130*pi/180); %8.3910
%K_pd=0.8526;
K_pd=sqrt((0.01*T_f)^2+0.01)/K; %0.8363

%system constants
psi_ref=30; %degrees
PM=50; %degrees
omega_c=0.10; %rad/s cross frequency;

H_ship=tf(K,[T 1 0]);
H_pd=tf(K_pd*[T_d 1],[T_f 1]);

%[Gm, Pm, Wcg, Wcp]=margin(H_ship*H_pd);
%[mag, phase, T_f]=bode(H_ship*H_pd);
figure;
hold on;
margin(H_ship*H_pd);
hold off;

t=compass_pd.time(1:1000);
psi_m=compass_pd.signals.values(1:1000);
delta_m=rudder_pd.signals.values(1:1000);

figure;
hold on;
title({'System with PD regulator with saturation for rudder';'No disturbance, only measurement noise'});
plot(t, psi_ref*ones(1000,1),'m');
plot(t,psi_m,'b',t,delta_m,'r');
xlabel('$Time/s$', 'Interpreter', 'latex');
ylabel('$Angle [deg]$', 'Interpreter', 'latex');
legend({'Compass reference','Compass measured','Rudder'});
hold off;

