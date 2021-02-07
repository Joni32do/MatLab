function zj = inv_dist(xi, yi, zi, xj, yj, p, method)
%This function implements the inverse-Distance-Interpolation for data in 
% the IR^2 
%The method can be altered with the last argument
%Valid expressions for method are loopIJ, loopI, loopJ, bsxfun, repmat, cross

%Motivation if I will find the time, I will try to implement this with the
%ability to choose diffrent metric
%Till now I will use norm(.)


%______________TO DO____________
%
%  - Implement p correctly
%
%  - diffrent cases
%
%  - Time Control


%Checks, whetche *i and *j have the same dimension
if size(xi) ~= size(yi) | size(xi) ~= size(zi)
    error('Wrong Dimensions in input Data');
end
if size(xj) ~= size(yj)
    error('Wrong Dimensions in points to interpolate');
end

tic

numelI = numel(xi);
numelJ = numel(xj);
weights = zeros(numelI,numelJ);
zj = zeros(numelJ,1);
metrikFun = @(x,y) sqrt(x.^2+y.^2)^d

%First we calculate the corresponding weights by the given method
switch method
    case {'loopIJ'}
        %You must calculate for every point to evaluate its distance to
        %every point of the input data
        for i = 1:numelI
           for j = 1:numelJ
               metrik = sqrt((xi(i)-xj(j)).^2+(yi(i)-yj(j)).^2);
               if metrik == 0
                   weights(i,j) = 0;
               else
                   weights(i,j) = 1/metrik.^p;
               end
           end
        end    
        
        
    case {'loopI'}
        for i = 1:numelI
          metrik = sqrt((xi(i)-xj).^2+(yi(i)-yj).^2)
          %The binary operater should 0 out any value which is nan
          weights(i) = (metrik ~= 0) .* (1/metrik^d); 
            
        end
        
        
        
    case {'loopJ'}
        for j = 1:numelJ
               metrik = sqrt((xi-xj(j)).^2+(yi-yj(j)).^2);
               %The binary operater should 0 out any value which is nan
               weights(j) = (metrik ~= 0) .* (1/metrik^d); 
        end
        weights = weights';
        
        
    case {'bsxfun'}
        bsxfun(metrikFun, xi, xj)
        
        
        
    case {'repmat'}
        
        
        
        
    case {'cross'}
        
        
        
    otherwise
        disp('Unknown method.');
             
end
        
%Now we going to interpolate the data:

for j = 1:numelJ
    %If there is an existing point
    if any(weights(:,j) == 0)
        disp('Hier bin ich');
        index = find(weights(:,j),0);
        zj(j) = zi(index);
    %Otherwise it will interpolate it
    else
        zj(j) = sum(zi.*weights(:,j))./sum(weights(:,j));
    end
    
end

toc
end
