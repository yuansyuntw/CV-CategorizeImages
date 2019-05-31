trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

trainLabelNum = 100;
testLabelNum = 10;
kmeanNum = 300;

[trainSet, trainLabels] = myKmeans(trainSetNames, trainLabelNum, kmeanNum);
[testSet, testLabels] = myKmeans(testSetNames, testLabelNum, kmeanNum);

maxKnum = 100;
accuracys = [];
axis = [];
index = 1;

f = uifigure;
d = uiprogressdlg(f, 'Title', 'KNN');

for i = 1:10:maxKnum
    a = myKNN(trainSet, trainLabels, testSet, testLabels, i, true, false) * 100;
    accuracys = [accuracys a];
    axis = [axis i];
    fprintf('k = %d, acc = %.2f%%\n', i, accuracys(index));
    index = index + 1;
    d.Value = updateprogressBar(i/maxKnum);
end
close(d);
close(f);

figure 
plot(axis, accuracys)
title('CV HW5 Task 2')
xlabel('k')
ylabel('accuracy(%)')