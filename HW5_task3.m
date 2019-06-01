trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

trainLabelNum = 100;
testLabelNum = 10;
kmeanNum = 300;

[trainSet, trainLabels] = myKmeans(trainSetNames, trainLabelNum, kmeanNum);
[testSet, testLabels] = myKmeans(testSetNames, testLabelNum, kmeanNum);

%% prepare for SVM
lambda = 0.001;
trainLength = length(trainLabels);

weightArray = []
biasArray = []
for i = 1:trainLabelNum
    
    svmLabels = ones(kmeanNum, trainLength).*-1;
    for i = 1:trainLength
       svmLabels(trainLabels(i), i) = 1;
    end

    [weight, bias] = vl_svmtrain(trainSet, svmLabels, lambda);

end

%% test the test data set
testLength = length(testLabels);
predicts = zeros(testLength, 1);
for j = 1:testLength
   
    distances = [];
    for k = 1:kmeanNum
        
        distances(k,:) = dot()
        
    end
    
end