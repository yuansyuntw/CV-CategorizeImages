function [dataSet, labels] = myKmeans(inputNames, labelNum, kmenasNum)

f = uifigure;
d = uiprogressdlg(f, 'Title', 'Get SIFT Features');

% get image descriptor with SIFT
[dataLength, nameLength] = size(inputNames);
trainDescroptorNum = [];
allDescroptors = [];
labels = zeros(dataLength,1);
for i = 1:dataLength
    
    % get the feature of input image
	originalImage = imread(char(inputNames(i)));
    [frame, descriptor] = vl_sift(single(originalImage), 'PeakThresh', 20, 'EdgeThresh', 20);
    
    % keep the index for vector quantization
    [descriptorLength, length] = size(descriptor);
    [descriptorLength, start] = size(allDescroptors);
    trainDescroptorNum(:,:,i) = [start+1 start+length];

    % for kmeans
    allDescroptors = [allDescroptors  descriptor];
    
    labels(i) = floor((i-1)/labelNum)+1;
    d.Value = updateprogressBar(i/dataLength);
    
    % imshow(originalImage);
    % hold on;
    % vl_plotsiftdescriptor(descriptor, frame);
    % hold off;
end
[centers, assignements] = vl_ikmeans(uint8(allDescroptors), kmenasNum);
close(f);

f = uifigure;
d = uiprogressdlg(f, 'Title', 'Vector Quantization');

% Vector Quantization
histograms = [];
for i=1:dataLength
   indexs = trainDescroptorNum(:,:,i);
   
   h = zeros(kmenasNum,1);
   for j=indexs(1):indexs(2)
       oneDescr = uint8(allDescroptors(:,j));
       word = vl_ikmeanspush(oneDescr, centers);
       h(word) = h(word) + 1;
   end
   histograms(:, i) = h;
   d.Value = updateprogressBar(i/dataLength);
end
close(f);

% for myKNN input format
dataSet = reshape(histograms, [], kmenasNum);

