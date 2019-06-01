trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

trainLabelNum = 100;
testLabelNum = 10;
kmeanNum = 260;
lamda = 0.01;

[trainHis, trainIndexs, trainLabels] = getSIFTFeatures(trainSetNames, trainLabelNum);
[testHis, testIndexs, testLabels] = getSIFTFeatures(testSetNames, testLabelNum);

[kMeansCenters, assignements] = vl_kmeans(single(trainHis), kmeanNum, 'Initialization', 'plusplus');
[trainSet] = vectorQuantization(trainHis, trainIndexs, kMeansCenters);
trainSet = trainSet';
[testSet] = vectorQuantization(testHis, testIndexs, kMeansCenters);
testSet = testSet';

%% prepare for SVM
f= uifigure;
d = uiprogressdlg(f, 'Title', 'Train SVM');
categoricalNumber = length(trainLabels)/trainLabelNum;
SVMWeights = []
SVMOffsets = []
for i = 1:categoricalNumber
    
    labels = ones(length(trainLabels), 1);
    labels = labels.*-1;
    
    for j = ((i-1)*trainLabelNum+1) : (i*trainLabelNum)
        labels(j) = 1;
    end
    
    [weight offset] = vl_svmtrain(trainSet, labels, lamda);
    SVMWeights(i,:) = weight;
    SVMOffsets(i,:) = offset;
    d.Value = updateprogressBar(i/categoricalNumber);
end
close(d);
close(f);


%% test the test data set
f= uifigure;
d = uiprogressdlg(f, 'Title', 'Testing SVM');
predictLabel = zeros(length(testLabels), 1);
testLength = length(testLabels);
for i = 1:testLength
    
    distances = []
    for j = 1:categoricalNumber
        distances(i) = dot(SVMWeights(j),testSet(:,i)) + SVMOffsets(j);
    end
    [p index] = max(distances);
    predictLabel(i) = index;
    d.Value = updateprogressBar(i/testLength);
end
accuracy = getAccuracy(predictLabel, testLabel);
close(d);
close(f);
    
figure 
image(accuracys)
title('CV HW5 Task 3')
xlabel('CategoricalPredictors')
ylabel('accuracy(%)')

csvwrite('task3_accuracys_answer.csv', accuracys');