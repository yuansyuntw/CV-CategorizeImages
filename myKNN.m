function accuracy = myKNN(trainSet, trainLabel, testSet, testLabel, kNumber, byMatlab)

% using matlab function
if(byMatlab==true)
   knn = fitcknn(trainSet, trainLabel,'NumNeighbors', kNumber);
    [predictLabel, scroe, cost] = predict(knn, testSet);

    accuracy = getAccuracy(predictLabel, testLabel);
else
% using ourself implement

    testSetLength = length(testLabel);
    trainSetLength = length(trainLabel);
    predictLabel = zeros(testSetLength, 1);
    for i = 1:testSetLength
        
        distances = zeros(trainSetLength, 2);
        for j = 1:trainSetLength
           distances(j, 1) = dist(testSet(i), trainSet(j)');
           distances(j, 2) = trainLabel(j);
        end

        distances = sort(distances, 1);
        kDistance = distances(1:kNumber,1);
        [maxTimes, index] = max(kDistance);
        predictLabel(i) = distances(index, 2);     
    end
    accuracy = getAccuracy(predictLabel, testLabel);
end






