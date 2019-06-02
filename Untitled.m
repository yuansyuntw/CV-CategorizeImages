X = [1 1; 2 2; 3 3]
X = X';
Label = [1 -1 -1]

[w,o] = vl_svmtrain(X, Label, 0.0001);

score = dot(w, X(:,1)) + o;




