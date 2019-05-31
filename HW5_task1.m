trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

tinySize = 16;
trainlabelNum = 100;
textLabelNum = 10;

trainLength = length(trainSetNames);
[trainSet, trainLabel] = tinyImages(trainSetNames, tinySize, trainlabelNum);
[testSet, testLabel] = tinyImages(testSetNames, tinySize, textLabelNum);

maxKNum = 500;
accuracys = [];
axis = [];
index = 1;

for i = 1:10:maxKNum
    a = myKNN(trainSet, trainLabel, testSet, testLabel, i, true) * 100;
    accuracys = [accuracys a];
    axis = [axis i];
    fprintf('k = %d, acc = %f%\n', i, accuracys(index));
    index = index + 1;
end

figure 
plot(axis, accuracys)
title('CV HW5 Task 1')
xlabel('k')
ylabel('accuracy(%)')






