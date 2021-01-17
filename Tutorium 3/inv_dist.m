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


numelI = numel(xi);
numelJ = numel(xj);
weights = zeros(numelI,numelJ);
zj = zeros(numelJ,1);

%First we calculate the corresponding weights by the given method
switch method
    case {'loopIJ'}
        %You must calculate for every point to evaluate its distance to
        %every point of the input data
        disp('this works')
        for i = 1:numelI
           for j = 1:numelJ
               metrik = (xi(i)-xj(j))^2+(yi(i)-xj(j))^2;
               if metrik == 0
                   weights(i,j) = 0;
               else
                   weights(i,j) = 1/metrik;
               end
           end
        end
        disp(weights)
      
        
        
    case {'loopI'}
        disp('Test')
        
        
        
    case {'loopJ'}
        disp('Test')
        
        
        
    case {'bsxfun'}
        
        
        
        
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
        disp('Das funktioiniert eigentlich')
       zj(j) = sum(zi.*weights(:,j))/sum(weights(:,j));
    end
    
end
end
