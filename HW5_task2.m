%% read data
trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

trainLabelNum = 100;
testLabelNum = 10;
minKMeanNum = 260;
maxKMeanNum = 260;
knnKNum = 21;

[trainHis, trainIndexs, trainLabels] = getSIFTFeatures(trainSetNames, trainLabelNum);
[testHis, testIndexs, testLabels] = getSIFTFeatures(testSetNames, testLabelNum);

%% k menas

f = uifigure;
d = uiprogressdlg(f, 'Title', 'KMeans');

accuracys = [];
axis = [];
index = 1;
for i = minKMeanNum:10:maxKMeanNum
    if(i==0)
        i = 2;
    end
    [kMeansCenters, assignements] = vl_kmeans(single(trainHis), i, 'Initialization', 'plusplus');
    [trainSet] = vectorQuantization(trainHis, trainIndexs, kMeansCenters);
    [testSet] = vectorQuantization(testHis, testIndexs, kMeansCenters);
    a = myKNN(trainSet, trainLabels, testSet, testLabels, knnKNum, false, false) * 100;
    accuracys = [accuracys a];
    axis = [axis i];
    fprintf('KMeans k = %d, acc = %.2f%%\n', i, accuracys(index));
    index = index + 1;
    d.Value = updateprogressBar(i/maxKMeanNum);
end
close(d);
close(f);

figure 
plot(axis, accuracys)
title('CV HW5 Task 2')
xlabel('kmeans k number')
ylabel('accuracy(%)')

csvwrite('task2_accuracys_answer.csv', accuracys');