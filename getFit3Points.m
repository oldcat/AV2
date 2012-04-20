% Takes three points and returns the coefficients of
% a plane equation of the form found from the three
% points.
%       
%       Ax + By + Cz = D
%
function [A, B, C, D] = getFit(p1, p2, p3)

    % find two vectors in the plane
    v12 = p2-p1;
    v13 = p3-p1;
    
    % get cross product
    cp = cross(v12, v13);
    
    A = cp(1);
    B = cp(2);
    C = cp(3);
    D = cp(1)*p1(1) + cp(2)*p1(2) + cp(3)*p1(3);
