clc
clear all
close all

images = readImages('images.txt');

points = importdata('3Dpoints.txt');
points =  points.data;
%color = repmat([50,50,40],length(points),1)/255;
color = points(:,4:6)/255;
ptCloud = pointCloud(points(:,1:3),'Color',color);
ptCloud = pcdenoise(ptCloud, 'NumNeighbors' ,30);
% plot
figure
grid off
hold on
pcshow(ptCloud);

for i=1:length(images)
    [ R ] = qvec2R( images(i,2:5));
    T = -images(i,6:8);
    if images(i,1)==96
        cam = plotCamera('Location',R'*T','Orientation',R,'Size',0.3, 'Color',[1 0 0],'Opacity',1);
    else
        cam = plotCamera('Location',R'*T','Orientation',R,'Size',0.15,  'Color',[0.7 0.7 0.7],'Opacity',0);
    end
    
    hold on
end