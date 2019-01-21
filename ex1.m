clear all;
close all;
hold on;

Z=zeros(1,4);
Z1=zeros(2,4);
I=ones(1,4);



x1=-1;y1=1;
x2=0;y2=2;
x3=-2;y3=1;
x4=1;y4=4;

u1=-1;v1=1;
u2=0;v2=2;
u3=2;v3=-1;
u4=1;v4=3;

 
U=[u1;u2;u3;u4];
V=[v1;v2;v3;v4];

X=[x1;x2;x3;x4];
Y=[y1;y2;y3;y4];

M=[I',Z',X,Y,Z1',X.^2,X.*Y;Z',I',Z1',X,Y,X.*Y,Y.^2];
M=[I',Z',X,Y,Z1',X.^2,X.*Y;Z',I',Z1',X,Y,X.*Y,Y.^2];
UV = [u1;u2;u3;u4;v1;v2;v3;v4];


W=M\UV;

quiver(X,Y,U,V,1,'color','r');
F=-10:10;

[XX,YY]=meshgrid(F);

Xx=W(1)+W(3)*XX+W(4)*YY+(W(7)*XX+W(8)*YY).*XX;
Yy=W(2)+W(5)*YY+W(6)*XX+(W(7)*XX+W(8)*YY).*YY;

quiver(XX,YY,Xx,Yy,1,'color','g');

