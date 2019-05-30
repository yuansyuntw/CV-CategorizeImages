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
    labelNum = trainLabel(end);
    
    for i = 1:testSetLength
        
        % calcuate the European distance with label
        distances = zeros(trainSetLength, 2);
        for j = 1:trainSetLength
           sample = testSet(i,:);
           train = trainSet(j,:);
           distances(j, 1) = dist(train, sample');
           distances(j, 2) = trainLabel(j);
        end

        % sort the distance and pick up the k number smaple
        distances = sortrows(distances, 1);
        kDistance = distances(1:kNumber,:);
        
        % vote the label
        voteLabels = zeros(labelNum, 1);
        for k = 1:kNumber
            index = uint8(kDistance(k,2));
            voteLabels(index) = voteLabels(index) + 1;
        end
        
        % pick up the most voted label
        [maxTimes, index] = max(voteLabels);
        predictLabel(i) = index;   
        
    end
    accuracy = getAccuracy(predictLabel, testLabel);
end






