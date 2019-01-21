function [Ex, Ey, Et]=Gradients(D1,D2)
[H1,W1]=size(D1) %On r�cup�re la taille du premier param�tre (matrice de l'image)
Mx=[0,0,0     %On d�finit une matrice de derivation M non sym�trique contrairement � la matrice de d�rivation de Sobel
    0,-1,1
    0,-1,1];
%Calculs permettant 
Mx=0.25*Mx; 
My = Mx';
Mt=abs(Mx); %Filtre Moyenneur
Ex=filter2(Mx,D1,'same')+filter2(Mx,D2,'same'); %Gradient Horizontal
% same permet de garder les dimensions de l'image
MEx=max(max(Ex)); %On r�cup�re la valeur maximale 
figure(2), subplot(1,3,1), %Affichage
imshow(histeq(abs(Ex)/MEx)),title('Gx'); %Histogramme normalis�
Ey=filter2(My,D1,'same')+filter2(My,D2,'same');%Gradient Vertical
MEy=max(max(Ey)); %On r�cup�re la valeur maximale 
figure(2), subplot(1,3,2),
imshow(histeq(abs(Ey)/MEy)),title('Gy'); %Histogramme normalis�
Et=D2-D1; %On prend la diff�rence des deux matrices d'image
Etm=max(max(Et)); %On prend la valeur maximale
Et=filter2(Mt,Et,'same');%Application d'un filtre moyenneur
figure(2), subplot(1,3,3),
imshow(abs(Et)/Etm),title('Gt'); %Affichage
end