function accuracy = myKNN(trainSet, trainLabel, testSet, testLabel, kNumber, byMatlab, progressmBar)

% using matlab function
if(byMatlab==true)
   knn = fitcknn(trainSet, trainLabel,'NumNeighbors', kNumber);
    [predictLabel, scroe, cost] = predict(knn, testSet);

    accuracy = getAccuracy(predictLabel, testLabel);
else
% using ourself implement

    if(progressmBar == true)
        f = uifigure;
        d = uiprogressdlg(f, 'Title','KNN - Vote the label');
    end

    testSetLength = length(testLabel);
    trainSetLength = length(trainLabel);
    predictLabel = zeros(testSetLength, 1);
    labelNum = trainLabel(end);
    for i = 1:testSetLength
        
        % calcuate the European distance with label
        distances = vl_alldist2(testSet(i,:)', trainSet', 'L2');

        % sort the distance and pick up the k number smaple
        [distances, indexArray] = sort(distances);
        
        % vote the label
        voteLabels = zeros(labelNum, 1);
        for k = 1:kNumber
            index = trainLabel(indexArray(k));
            voteLabels(index) = voteLabels(index) + 1;
        end
        
        % pick up the most voted label
        [maxTimes, index] = max(voteLabels);
        predictLabel(i) = index;
        
        if(progressmBar == true)
            d.Value = updateprogressBar(i/testSetLength);
        end
        
    end
    if(progressmBar == true)
        close(f);
    end
    accuracy = getAccuracy(predictLabel, testLabel);
end






