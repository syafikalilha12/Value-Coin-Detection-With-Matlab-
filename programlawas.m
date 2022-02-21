clc 
clear
close all 

koin=imread('koin.png');
gray=rgb2gray(koin);
bw = im2bw(gray,graythresh(gray));
figure,imshow(bw);
bw = imcomplement(bw);
figure,(imshow(bw));
bw=bwareaopen(bw,100);
bw = imfill(bw,'holes');
str=strel('disk',5);
bw=imclose(bw,str);
bw=imclearborder(bw);
%figure,imshow(bw);
[B,L]=bwlabel(bw);
stats=regionprops(B,'All');
figure, imshow(koin);
hold on
bound = bwboundaries(bw,'noholes')

for n=1:L
    boundary = bound{n};
    Area = stats(n).Area;
    centroid = stats(n).Centroid;
    if Area<180000
        nilai=100;
    else
        nilai=500;
    end
    plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 4)
        % menampilkan nilai koin pada centroid objek
    text(centroid(1)-50,centroid(2),num2str(nilai),'Color','y','FontSize',20,'FontWeight','bold');
    jumlah = 0;
    data_koin(n) = nilai;
    for i = 1:length(data_koin)
        jumlah = jumlah + data_koin(i);
    end
    out = jumlah;
end
[~,n_100] = find(data_koin==100);
    nilai_100 = numel(n_100);
[~,n_500] = find(data_koin==500);
    nilai_500 = numel(n_500);
fprintf("Jumlah uang 100  : %2.f Keping\n", nilai_100);
fprintf("Jumlah uang 500  : %2.f Keping\n", nilai_500);
fprintf("Total seluruh uang = Rp. %2.f ", out);
        
        
        
        
        
        
        
        
        
        
        
        
        