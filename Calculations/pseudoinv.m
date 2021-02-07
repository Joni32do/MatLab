A = [1 0] + i * [1 1]
B = [0 1]' + i * [1 0]'
pA = pinv(A)
pB = pinv(B)
AB = A*B
pAB = pinv(AB)
pB * pA