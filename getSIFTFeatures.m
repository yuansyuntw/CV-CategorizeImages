function [allDescriptors, trainDescriptorIndexs, labels] = getSIFTFeatures(inputNames, labelNum)

% get image descriptor with SIFT
f = uifigure;
d = uiprogressdlg(f, 'Title', 'Get SIFT Features');

[dataLength, ~] = size(inputNames);
trainDescriptorIndexs = [];
allDescriptors = [];
labels = zeros(dataLength,1);
for i = 1:dataLength
    
    % get the feature of input image
	originalImage = imread(char(inputNames(i)));
    [frame, descriptor] = vl_sift(single(originalImage), 'PeakThresh', 0, 'edgethresh', 3.5);
    
    % keep the index for vector quantization
    [~, length] = size(descriptor);
    [~, start] = size(allDescriptors);
    trainDescriptorIndexs(:,:,i) = [start+1 start+length];

    % for kmeans
    allDescriptors = [allDescriptors  descriptor];
    
    labels(i) = floor((i-1)/labelNum)+1;
    d.Value = updateprogressBar(i/dataLength);
    
    % debug
    if(i == 1)
        I = imread(char(inputNames(i)));
        image(I);
        features = vl_plotframe(frame(:,:));
        set(features, 'color', 'k', 'linewidth', 2);
    end
    
end
close(d);
close(f);
