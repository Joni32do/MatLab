function [Z] = f2(X,Y);
Z = sqrt(X.^2 + Y.^2)+eps;
Z = sin(Z)./(Z);
end