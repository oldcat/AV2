% Converts a position number in a binary position to 
% the actual position of that pixel
%
function [num] = pos2NumBin(pos, bin, minX)

    if pos(1) > 1
        num = sum(sum(bin(1:(pos(1)-1),:)));
    end
    
    for c = minX:pos(2)
        if bin(pos(1),pos(2)) == 1
            num = num+1;
        end
    end
