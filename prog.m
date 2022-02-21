clc 
clear
Img = imread('cuan5.jpg');
Img_gray = rgb2gray(Img);
gambar = imbinarize(Img_gray,graythresh(Img_gray));
gambar = imcomplement(gambar);
gambar = bwareaopen(gambar,500);
gambar = imfill(gambar,'holes');
[B,L] = bwlabel(gambar);
stats = regionprops(B,'All');
imshow(Img);
hold on
Boundaries = bwboundaries(gambar,'noholes');
    data_koin = zeros(L,1);
    out = 0;
for n = 1:L
    boundary = Boundaries{n};
    bw_label = (B==n);
    Area = stats(n).Area;
    centroid = stats(n).Centroid;
        if Area<3800 && Area>1000
            nilai = 100;
        elseif Area<4000 && Area>3800
            nilai = 1000;
        elseif Area<5000 && Area>4000
            nilai = 200;
        else
            nilai = 500;
        end
        plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 2)
        text(centroid(1)-50,centroid(2),num2str(nilai),...
            'Color','b','FontSize',20,'FontWeight','bold');
        jumlah = 0;
        data_koin(n) = nilai;
        for i = 1:length(data_koin)
            jumlah = jumlah + data_koin(i);
        end
        out = jumlah;
end
[~,n_100] = find(data_koin==100);
    nilai_100 = numel(n_100);
[~,n_200] = find(data_koin==200);
    nilai_200 = numel(n_200);
[~,n_500] = find(data_koin==500);
    nilai_500 = numel(n_500);
[~,n_1000] = find(data_koin==1000);
    nilai_1000 = numel(n_1000);
fprintf("Jumlah uang 100  : %2.f Keping\n", nilai_100);
fprintf("Jumlah uang 200  : %2.f Keping\n", nilai_200);
fprintf("Jumlah uang 500  : %2.f Keping\n", nilai_500);
fprintf("Jumlah uang 1000 : %2.f Keping\n", nilai_1000);
fprintf("Total seluruh uang = Rp. %2.f ", out);