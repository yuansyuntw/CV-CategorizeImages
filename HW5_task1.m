%% read data
trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

tinySize = 16;
trainlabelNum = 100;
textLabelNum = 10;

trainLength = length(trainSetNames);
[trainSet, trainLabels] = tinyImages(trainSetNames, tinySize, trainlabelNum);
[testSet, testLabels] = tinyImages(testSetNames, tinySize, textLabelNum);

%% run KNN
maxKnum = 100;
accuracys = [];
axis = [];
index = 1;

f = uifigure;
d = uiprogressdlg(f, 'Title', 'KNN');

for i = 1:1:maxKnum
    a = myKNN(trainSet, trainLabels, testSet, testLabels, i, false, false) * 100;
    accuracys = [accuracys a];
    axis = [axis i];
    fprintf('k = %d, acc = %.2f%%\n', i, accuracys(index));
    index = index + 1;
    d.Value = updateprogressBar(i/maxKnum);
end
close(f);

figure 
plot(axis, accuracys)
title('CV HW5 Task 1')
xlabel('k')
ylabel('accuracy(%)')

csvwrite('task1_accuracys_L2.csv', accuracys');






