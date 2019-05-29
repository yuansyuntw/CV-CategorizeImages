trainSet = glob('train/**/*.jpg');
testSet = glob('test/**/*.jpg');

tinySize = 16;
trainLength = length(trainSet);
trainVectors = zeros(trainLength, tinySize*tinySize);
for i = 1:trainLength
    orignalImage = imread(char(trainSet(i)));
    scaleImage = imresize(orignalImage, [tinySize tinySize]);
    reshapImage = reshape(scale_image, 1, []);
    disp(class(trainVectors(i)));
    disp(class(reshapImage));
end

numData = 5000;
dimension = 2;
data = rand(dimension, numData);

numClusters = 30;
[centers, assignemtns] = vl_kmeans(data, numClusters);

figure
hold on;
scatter(data(1,:), data(2,:), 18, 'MarkerFaceColor', [0 0 0]);
scatter(centers(1,:), centers(2,:), 144, 'MarkerFaceColor', [0 0.7 0.7]);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)'; 
ylabel 'Petal Widths (cm)';
hold off;