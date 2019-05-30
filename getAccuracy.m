function accuracy = getAccuracy(predictLabel, answerLabel)

if(length(predictLabel) ~= length(answerLabel))
   disp('The answer label number not match predict label number'); 
end

correctCount = 0;
for i = 1:length(predictLabel)
    if(predictLabel(i)==answerLabel(i))
        correctCount = correctCount + 1;
    end
end
accuracy = correctCount/length(predictLabel);
