trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

kmeanNum = 10;

% get image descriptor with SIFT
trainLength = length(trainSetNames);
trainDescroptors = [];
allDescroptors = [];
for i = 1:trainLength
	originalImage = imread(char(trainSetNames(i)));
    [frame, descriptor] = vl_sift(single(originalImage), 'PeakThresh', 20, 'EdgeThresh', 20);
    
    % for vector quantization
    trainDescroptors(i) = descriptor;
    
    % for kmeans
    allDescroptors = [allDescroptors  descriptor];
    
    % imshow(originalImage);
    % hold on;
    % vl_plotsiftdescriptor(descriptor, frame);
    % hold off;
end
[centers, assignements] = vl_ikmeans(uint8(allDescroptors), kmeanNum);

% Vector Quantization
histograms = [];
for j=1:trainLength
   histograms = vl_ikmeanspush(uint8(trainDescroptor(:,j)), centers);
end










