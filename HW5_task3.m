trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

trainLabelNum = 100;
testLabelNum = 10;
kmeanNum = 300;
minLamda = 0.0000001;
maxLamda = 1;

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

lamda = minLamda;
accuracys = [];
xaxis = [];
index = 1;
while (lamda <= maxLamda)
    
    [svmWeights, svmOffsets] = trainSVM(trainSet, trainLabels, trainLabelNum, lamda);
    
    % test the test data
    predictLabel = zeros(length(testLabels), 1);
    testLength = length(testLabels);
    [~, categoricalNumber] = size(svmWeights);
    for i = 1:testLength

        % predict the label
        distances = zeros(categoricalNumber, 1);
        for j = 1:categoricalNumber
            w = svmWeights(:,j);
            test = testSet(:,i);
            offset = svmOffsets(:,j);
            distances(j) = dot(w, test) + offset;
        end
        [p, label] = max(distances);
        predictLabel(i) = label;
        d.Value = updateprogressBar(i/testLength);
        
    end
    
    % get the accuracy
    acc = getAccuracy(predictLabel, testLabels);
    accuracys(index) = acc;
    xaxis(index) = lamda;
    
    d.Value = updateprogressBar(i/categoricalNumber);
    lamda = lamda * 10;
    index = index + 1;
end
close(d);
close(f);
    
figure 
plot(xaxis, accuracys)
title('CV HW5 Task 3')
xlabel('SVM Regularization Coefficient')
ylabel('accuracy(%)')

csvwrite('task3_accuracys_answer.csv', accuracys');