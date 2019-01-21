close all;clear all;
data1=imread('AT3_1m4_01.tif'); % bact�ries
data2=imread('AT3_1m4_04.tif'); 
data1=im2double(data1(:,:,1));%convertit image 1 sous forme de matrice de type double
data2=im2double(data2(:,:,1));%convertit image 2 sous forme de matrice de type double
[Ni,Nj]=size(data1);%r�cup�ration de la taille de la matrice(hauteur et largeur)
subplot(1,2,1),
imshow(data1),title('Image � t=t_0');%affichage de l'image par la matrice
subplot(1,2,2),
imshow(data2),title('Image � t=t_0+dt');%affichage de l'image par la matrice

[Ex, Ey, Et]=Gradients(data1,data2);%Calcul et affichage des 3 op�rateurs appliqu� aux 2 param�tres
U=data1.*0.0;V=data2.*0.0; %On initialise U et V par une matrice de m�me taille que l'image remplies de 0
a=0.075;
NGrad = Ex.^2 + Ey.^2 + a^2; %Norme au carr�
Niter = 20; %Nombre d'it�rations maximum
M=(1/12)*[1,2,1  %Filtre moyenneur
          2,0,2
          1,2,1];

for i=1:Niter
Ub=filter2(M,U,'same'); %On applique une corr�lation entre la matrice M et la matrice U
Vb=filter2(M,V,'same'); %On applique une corr�lation entre la matrice M et la matrice V
Tmp=Ex.*Ub + Ey.*Vb + Et; %On d�finit Tmp afin de d�composer l'expression du sch�ma it�ratif n�cessaire � faire le flot optique
Tmpx=Ex.*Tmp./NGrad; %On prend la premi�re composante normalis�e de Tmp
Tmpy=Ey.*Tmp./NGrad; %On prend la deuxi�me composante normalis�e de Tmp
Usuiv=Ub - Tmpx; %On soustrait � la matrice de l'image la premi�re composante normalis�e de Tmp
Vsuiv=Vb - Tmpy; %On soustrait � la matrice de l'image la deuxi�me composante normalis�e de Tmp
U=Usuiv;
V=Vsuiv;
N=max(max(U)) + max(max(V)); %On additionne les valeurs maximales des deux matrices de l'image
figure(3),
subplot(1,2,1),imshow(1.*(abs(U)./N)),title('U');%On affiche la valeur absolue de la matrice de l'image U normalis�e par la valeur maximale des deux images
subplot(1,2,2),imshow(1.*(abs(V)./N)),title('V');%On affiche la valeur absolue de la matrice de l'image V normalis�e par la valeur maximale des deux images
indU=find(abs(U)>0.05*(max(max(U)))); %On r�cup�re les indices qui v�rifient la condition --> On veut r�cup�rer seulement les valeurs maximales respectant la condition (seuillage) 
Uplot=U.*0; %Initialisation de Uplot
Uplot(indU)=U(indU); %On remplit Uplot par les indices pr�c�demment trouv�s
Um=max(max(Uplot)); %On s�l�ctionne la valeur maximale de la matrice
figure(4),subplot(1,2,1),
imshow(256*(abs(Uplot)/Um)),title('Uplot>0.05U'); %On affiche la normalisation de Uplot
indV=find(abs(V)>0.05*(max(max(V))));%On r�cup�re les indices qui v�rifient la condition--> On veut r�cup�rer seulement les valeurs maximales respectant la condition (seuillage)
Vplot=V.*0; %Initialisation de Vplot
Vplot(indV)=U(indV);%On remplit Vplot par les indices pr�c�demment trouv�s
Vm=max(max(Vplot)); %On s�l�ctionne la valeur maximale de la matrice
figure(4), subplot(1,2,2),
imshow(256*(abs(Vplot)/Vm)),title('Vplot>0.05V');%On affiche la normalisation de Vplot
end


figure(5),
G=sqrt(U.*U + V.*V); %Norme des deux matrices de l'image
indice=find(G>0.005*G); %On r�cup�re les indices qui v�rifient l'in�quation
Uplot=U.*0; Vplot=V.*0; %On r�initialise Uplot et Vplot de m�me tailles que U et V remplies de 0
Uplot(indice)=U(indice); %On remplit Uplot par les indices pr�c�demment trouv�s
Vplot(indice)=V(indice); %On remplit Vplot par les indices pr�c�demment trouv�s
Uplotb = Uplot(1:8:Ni,1:8:Nj); %On remplit la matrice Uplotb seulement avec 1 valeurs sur 8 jusqu'� la dimension max de l'image
Vplotb = Vplot(1:8:Ni,1:8:Nj); %On remplit la matrice Vplotb seulement avec 1 valeurs sur 8 jusqu'� la dimension max de l'image
quiver(flipud(Uplotb),flipud(-Vplotb)),title('Flot optique'); %On affiche le champ de vecteurs correspondant aux 2 matrices Uplotb et -Vplotb

figure(6),
subplot(2,2,1),imshow(data1),title('Image � t=t_0'); %Affichage de l'image de base
subplot(2,2,2),imshow(data2),title('Image � t=t_0+dt'); %Affichage de l'image de base 2
subplot(2,2,3),imshow(1.*(abs(U)./N)),title('U'); %Affichage de l'image apr�s traitement (gradients appliqu�s)
subplot(2,2,4),imshow(1.*(abs(V)./N)),title('V'); %Affichage de l'image apr�s traitement (gradients appliqu�s)
