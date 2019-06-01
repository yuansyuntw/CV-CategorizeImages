A = zeros(128, 2);

for i = 1:2
    for j = 1:128
        A(j,i) = j;
    end
end

B = A'