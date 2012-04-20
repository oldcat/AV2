function main2D()

    [bgDepths, bgIm] = getBackground;
    outputImages = cell(36);

    for i = 1:36
        fprintf('%d\n', i);
        filename = ['bindermat/xyzrgb_frame_' sprintf('%04d', i) '.mat'];
    
        [fgDepths, fgIm] = input2image(importdata(filename));

        %figure(1)
        %imshow(bgIm)
        %figure(2)
        %imshow(fgIm)

        newDepth = abs(bgDepths(:,:,3) - fgDepths(:,:,3));
        showable = newDepth-min(min(newDepth));
        showable = showable/max(max(showable));

        %figure(3)
        %imshow(showable);
        %figure(4)
        %hist(showable(:),200);

        fgBin = (showable>=0.03) & (showable<=0.45);
        fgCln = myCleanup(fgBin,2,3);
        
        better = fgDepths(:,:,3)-min(min(fgDepths(:,:,3)));
        better = better/max(max(better));
        better = better .* double(fgBin);
        better = better/max(max(better));
        
        %figure(5)
        %imshow(better);
           
        %figure(6)
        manInIm = zeros(480, 640, 3);
        % put in background
        manInIm(:,:,1) = bgIm(:,:,1) .* double(~fgBin);
        manInIm(:,:,2) = bgIm(:,:,2) .* double(~fgBin);
        manInIm(:,:,3) = bgIm(:,:,3) .* double(~fgBin);
        
        % put in foreground
        manInIm(:,:,1) = manInIm(:,:,1) + (fgIm(:,:,1) .* double(fgBin));
        manInIm(:,:,2) = manInIm(:,:,2) + (fgIm(:,:,2) .* double(fgBin));
        manInIm(:,:,3) = manInIm(:,:,3) + (fgIm(:,:,3) .* double(fgBin));
           
        sortedBetter = sort(better(:), 'descend');
        threshold = sortedBetter(13000);
        %planeBin = newGetLargest(myCleanup(better>threshold,0,2));%0.936,0,2));
        planeBin = newGetLargest(myCleanup(better>0.936,0,2));
%        figure(i);
%        imshow(planeBin)
        countPixels = sum(sum(planeBin==1));
        counts = find(sum(planeBin)>0);
        if (countPixels > 8000) | ((countPixels > 5000) & (counts(end) < 600) & (counts(1) > 40))
            planeBin = newGetLargest(myCleanup(better>threshold,0,2));
        else
            planeBin = zeros(480,640);
        end
%        planeBin = newGetLargest(myCleanup(fgDepths(41:466,21:598,3)>=-1.54,0,2));
        finalIm = manInIm;
%        figure(1);
%        imshow(planeBin)
%        fprintf('=> %d\n', countPixels);
%        imwrite(planeBin,  ['using_better/normalisationBest_' sprintf('%04d', i) '.png'], 'png');
%        imwrite(planeBin,  ['using_fgDepths/noNormalisationBest_' sprintf('%04d', i) '.png'], 'png');

%        finalIm = zeros(480,640,3);

        if (getArea(planeBin)>50)
            [r,c] = find(bwperim(planeBin,4)==1);
            [sr,sc] = newRemoveSpurs(r,c,480,640,0);
            [tr,tc] = newBoundaryTrack(sr,sc,480,640,0);
            attemptCount = 0;
            while length(tr) < 20 & length(r) > 100
                attemptCount = attemptCount + 1;
                toRemove = zeros(1,length(tr));
                for j = 1 : length(tr)
                    toRemove(j) = find(r==tr(j) & c==tc(j));
                end
                r(toRemove) = [];
                c(toRemove) = [];
                [r,c] = newRemoveSpurs(r,c,480,640,0);
                [sr,sc] = newRemoveSpurs(r,c,480,640,0);
                [tr,tc] = newBoundaryTrack(sr,sc,480,640,0);
%                figure(attemptCount+2);
%                imshow(setPixels([tr,tc]))
            end
            [numlines, datalines] = newFindCorners(tr,tc,480,640,0,10);
            lengths = lineLengths(numlines, datalines);
            corners = getAllCorners(lengths, numlines, datalines, 0);
            finalIm = remapVideo(i, manInIm, corners, 0);
%            finalIm = remapVideo(i, finalIm, corners, 0);
        end

        %figure(i)
        %imshow(manInIm)
        %figure(i+36)
        %imshow(myCleanup(planeBin,4,4))
        %figure(i+72)
        %imshow(myCleanup(better>0.94,0,2))

        outputImages{i} = finalIm;
%        imwrite(finalIm, ['~/Desktop/AV2/Binaries2D/' sprintf('%04d', i) '.jpg'],'jpg');

    end

    figure(1000);
%    aviWriter(outputImages);

% imwrite(planeBin,'~/Desktop/AV2/planeBin.jpg','jpg');
