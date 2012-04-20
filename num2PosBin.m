function [point] = num2PosBin(num, bin, minY, maxX)
    
    dim = size(bin);
    
    point = zeros(2,1);
    
    
    totalPoints = 0;
    oddThing = sum(sum(bin(minY:end,:)));
    for r = minY:dim(1)
        totalPoints = totalPoints + sum(bin(r,:));
        newTot = totalPoints;
        if num <= totalPoints
            for c = maxX:-1:1
                if num == newTot
                    point = [r,c];
                    break
                end
                if bin(r,c) == 1
                    newTot = newTot-1;
                end
            end
        end
        if point(1) > 0
            break
        end
    end
