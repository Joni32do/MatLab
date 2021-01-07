function Z = f4(X,Y)
Z = zeros(size(X));
for k = 1:2
    Out = abs(sin(X)+1.5).^Y./k;
    Z = Out + Z;
end
end