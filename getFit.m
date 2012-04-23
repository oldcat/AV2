% Takes three points and returns the coefficients of
% a plane equation of the form found from the three
% points.
%       
%       Ax + By + Cz = D
%
function [A, B, C, D] = getFit(points, noise)

    dimP = size(points);
    numPoints = dimP(2);
    
    matX = [];
    matY = [];
    
    for i = 1:numPoints
        matX = [matX; points(1,i) points(2,i) 1];
        matY = [matY; points(3,i)];        
    end

    weights = matX\matY;
   
    A = weights(1);
    B = weights(2);
    C = -1;
    D = -weights(3);
