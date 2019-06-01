function [dataSet, labels] = myKmeans(inputNames, labelNum, kmenasNum)

f = uifigure;
d = uiprogressdlg(f, 'Title', 'Get SIFT Features');

% get image descriptor with SIFT
[dataLength, nameLength] = size(inputNames);
trainDescriptorIndexs = [];
allDescriptors = [];
labels = zeros(dataLength,1);
for i = 1:dataLength
    
    % get the feature of input image
	originalImage = imread(char(inputNames(i)));
    [frame, descriptor] = vl_sift(single(originalImage), 'PeakThresh', 0, 'edgethresh', 3.5);
    
    % keep the index for vector quantization
    [descriptorLength, length] = size(descriptor);
    [descriptorLength, start] = size(allDescriptors);
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
d.Message  = "progress vl_ikmeans...";
[centers, assignements] = vl_ikmeans(uint8(allDescriptors), kmenasNum);
close(d);
close(f);

f = uifigure;
d = uiprogressdlg(f, 'Title', 'Vector Quantization');

% Vector Quantization
histograms = [];
for i=1:dataLength
   indexs = trainDescriptorIndexs(:,:,i);
   startIndex = indexs(1);
   endIndex = indexs(2);
   h = zeros(kmenasNum,1);
   for j = startIndex:endIndex
       oneDescr = int32(allDescriptors(:,j));
       [distance, index] = min(vl_alldist2(oneDescr, centers));
       word = index;
       h(word) = h(word) + 1;
   end

   % To regularize the histogram
   h = h - mean(h);
   histograms(:, i) = h/norm(h);
   
   d.Value = updateprogressBar(i/dataLength);
end
close(d);
close(f);

% for myKNN input format
dataSet = reshape(histograms, [], kmenasNum);

