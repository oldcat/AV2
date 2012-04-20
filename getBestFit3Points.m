function [bestQual] = getBestFit(curArea,fitTol)

    runs = 10;

    dim = size(curArea);

    randP = zeros(2,3);

    bestQual = 0;

    for i = 1:100
        notDifferent = 1;
        while notDifferent
            randP(1,:) = ceil(dim(1)*rand(1,3));
            randP(2,:) = ceil(dim(2)*rand(1,3));
            
            notDifferent = 0;
            
            if randP(1,1) == randP(1,2)
                if randP(2,1) == randP(2,2)
                    notDifferent = 1;
                end
            end
            
            if randP(1,1) == randP(1,3)
                if randP(2,1) == randP(2,3)
                    notDifferent = 1;
                end
            end

            if randP(1,2) == randP(1,3)
                if randP(2,2) == randP(2,3)
                    notDifferent = 1;
                end
            end
        end
               
        p1 = curArea(randP(1,1),randP(2,1),:);
        p2 = curArea(randP(1,2),randP(2,2),:);
        p3 = curArea(randP(1,3),randP(2,3),:);
        
        [A, B, C, D] = getFit3Points(p1,p2,p3);
        
        quality = checkFit([A, B, C, D], curArea, fitTol);
        fprintf('Run: %03d\tQuality:%4.2f\n',i,quality);
        
        if quality > bestQual
            bestQual = quality;
        end
    end
