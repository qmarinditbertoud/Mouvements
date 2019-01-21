clear all;close all;hold on;
X=[1,-1,-2,2]'; %Matrice X des premières composantes des 4 points
Y=[2,3,-1,-2]'; %Matrice Y des deuxièmes composantes des 4 points
plot([X;X(1)],[Y;Y(1)],'r','linewidth',2); %Affichage des points
U=0.2*[0.2,0.2,0.5,0.7]'; %Vecteur Vitesse
V=0.2*[-0.1,-0.5,-0.5,-0.2]'; %Vecteur Vitesse
W=[U;V]; %On met bout à bout les matrices U et V
E=ones(4,1),Z=zeros(4,1); %Création de matrices de 1 et de 0
M=[E,Z,X,Y,Z,Z,X.^2,X.*Y
   Z,E,Z,Z,X,Y,X.*Y,Y.^2]; %Mise en place de la Matrice des coordonnées des points (cf Cours)
S=M\W;u0=S(1);v0=S(2); %cf Cours (emplissage de Matrice)
A=S(3);B=S(4);C=S(5);
D=S(6);E=S(7);F=S(8);
I=-10:10; %Vecteur de longueur 20
set(gcf,'color','w');
[XX,YY]=meshgrid(I,I); %On met en place une grille de dimensions I
Xp=u0+A*XX+B*YY+(E*XX+F*YY).*XX; %On calcule X point
Yp=v0+C*XX+D*YY+(E*XX+F*YY).*YY; %On calcule Y point
quiver(XX,YY,10*Xp,10*Yp,0); %On affiche le champ de vecteur
q=quiver(X,Y,10*U,10*V,0,'color','r','linewidth',2); %On affiche les vecteurs déterminant la translation del'objet