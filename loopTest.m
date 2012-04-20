boxR = 0;
boxC = 0;
minX = 0;
minY = 0;
maxY = 200;
maxX = 100;
boxDim = 15;
notFound = 1;
while notFound & ((boxR + boxDim - 1) <= maxY)
    % update loop counters
    boxC = boxC + boxDim/2
    if (boxC + boxDim - 1) > maxX
        boxC = minX
        boxR = boxR + boxDim/2
    end
end

endR = boxR
endC = boxC

