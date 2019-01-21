function traj;
clear all; close all;
t=0:0.01:10;
sed = @(t,v) SED(v);
V0=[1;0];
[t,v] = ode45(sed,t,V0);
plot(v(:,1),v(:,2));


function der=SED(v);
x=v(1);y=v(2);
xp=0.1*v(1)+v(2);
yp=-v(1) + 0.1*v(2);
der=[xp;yp]

