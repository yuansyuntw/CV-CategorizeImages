trainSetNames = glob('train/**/*.jpg');
testSetNames = glob('test/**/*.jpg');

tinySize = 16;
trainlabelNum = 100;
textLabelNum = 10;

trainLength = length(trainSetNames);
[trainSet, trainLabel] = tinyImages(trainSetNames, tinySize, trainlabelNum);
[testSet, testLabel] = tinyImages(testSetNames, tinySize, textLabelNum);

kNum = 1;

accuracy = myKNN(trainSet, trainLabel, testSet, testLabel, kNum, false);
disp('accuracy'+accuracy);