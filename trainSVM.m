function [SVMWeights, SVMOffsets] = trainSVM(trainSet, trainLabels, trainLabelNum, lamda)

categoricalNumber = length(trainLabels)/trainLabelNum;

SVMWeights = [];
SVMOffsets = [];
for i = 1:categoricalNumber
    
    labels = ones(length(trainLabels), 1);
    labels = labels.*-1;
    
    for j = ((i-1)*trainLabelNum+1) : (i*trainLabelNum)
        labels(j) = 1;
    end
    
    [weight, offset] = vl_svmtrain(trainSet, labels, lamda);
    SVMWeights(:,i) = weight;
    SVMOffsets(:,i) = offset;
    
end