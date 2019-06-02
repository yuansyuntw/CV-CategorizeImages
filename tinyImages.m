function [tinyData, labelData] = tinyImages(inputNames, tinySize, labelNum)

trainLength = length(inputNames);
tinyData = zeros(trainLength, tinySize*tinySize, 'uint8');
labelData = zeros(trainLength, 1);
for i = 1:trainLength
    % disp(inputNames(i));
    orignalImage = imread(char(inputNames(i)));
    scaleImage = imresize(orignalImage, [tinySize tinySize]);
    reshapImage = reshape(scaleImage, 1, []);
    tinyData(i,:) = reshapImage;
    labelData(i) = floor((i-1)/labelNum)+1;
end
