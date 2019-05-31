A = uint8([1 2 3 4])

[c, a] = vl_ikmeans(A, 2);

t = vl_ikmeanspush(uint8(2), c);
