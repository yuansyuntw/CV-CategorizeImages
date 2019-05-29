trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

tinySize = 16;
trainlabelNum = 100;
textLabelNum = 10;

trainLength = length(trainSetNames);
[trainSet, trainLabel] = tinyImages(trainSetNames, tinySize, trainlabelNum);
[testSet, testLabel] = tinyImages(testSetNames, tinySize, textLabelNum);

kNum = 5;

Mdl = fitcknn(trainSetNames, trainLabel,'NumNeighbors', kNum);

figure
hold on;
scatter(data(1,:), data(2,:), 18, 'MarkerFaceColor', [0 0 0]);
scatter(centers(1,:), centers(2,:), 144, 'MarkerFaceColor', [0 0.7 0.7]);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)'; 
ylabel 'Petal Widths (cm)';
hold off;