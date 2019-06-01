trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

trainLabelNum = 100;
testLabelNum = 10;
kmeanNum = 260;

[trainHis, trainIndexs, trainLabels] = getSIFTFeatures(trainSetNames, trainLabelNum);
[testHis, testIndexs, testLabels] = getSIFTFeatures(testSetNames, testLabelNum);

[kMeansCenters, assignements] = vl_kmeans(single(trainHis), kmeanNum, 'Initialization', 'plusplus');
[trainSet] = vectorQuantization(trainHis, trainIndexs, kMeansCenters);
[testSet] = vectorQuantization(testHis, testIndexs, kMeansCenters);

%% prepare for SVM
lambda = 0.001;
SVMModel = fitcsvm(trainSet, trainLabels, lambda);

%% test the test data set
predicts = predict(SVMModel, testSet);
accuracy = getAccuracy(predicts, testLabel);

figure 
plot(axis, accuracys)
title('CV HW5 Task 3')
xlabel('CategoricalPredictors')
ylabel('accuracy(%)')

csvwrite('task3_accuracys_answer.csv', accuracys');