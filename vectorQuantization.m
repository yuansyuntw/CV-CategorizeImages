function [dataSet] = vectorQuantization(allDescriptors, trainDescriptorIndexs, kmeansCenters)

if(kmeansCenters==1)
   disp("kmeansCenters can't is one"); 
end

% Vector Quantization
f = uifigure;
d = uiprogressdlg(f, 'Title', 'Vector Quantization');

histograms = [];
[~, ~, dataLength] = size(trainDescriptorIndexs);
[~, kmenasNum] = size(kmeansCenters);
for i=1:dataLength
   indexs = trainDescriptorIndexs(:,:,i);
   startIndex = indexs(1);
   endIndex = indexs(2);
   h = zeros(kmenasNum,1);
   for j = startIndex:endIndex
       oneDescr = single(allDescriptors(:,j));
       [~, index] = min(vl_alldist2(oneDescr, kmeansCenters));
       h(index) = h(index) + 1;
   end

   % To regularize the histogram
   h = h - mean(h);
   histograms(:, i) = h/norm(h);
   
   d.Value = updateprogressBar(i/dataLength);
end
close(d);
close(f);

% for myKNN input format
dataSet = histograms';