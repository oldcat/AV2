function finalMain3D()

    [bgDepths, bgIm] = getBackground;
    outputImages = cell(36);

    for i = 1:36
        fprintf('%d\n', i);
        filename = ['bindermat/xyzrgb_frame_' sprintf('%04d', i) '.mat'];
        [fgDepths, fgIm] = input2image(importdata(filename));
%        bgIm = overlay(fgIm, remapField);

        newDepth = abs(bgDepths(:,:,3) - fgDepths(:,:,3));
        showable = newDepth-min(min(newDepth));
        showable = showable/max(max(showable));

        fgBin = (showable>=0.03) & (showable<=0.45);
        fgCln = newGetLargest(double(myCleanup(fgBin,2,3)));
        
        better = fgDepths(:,:,3)-min(min(fgDepths(:,:,3)));
        better = better/max(max(better));
        better = better .* double(fgBin);
        better = better/max(max(better));
        
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
        planeBin = newGetLargest(myCleanup(better>0.936,0,2));
        countPixels = sum(sum(planeBin==1));
        counts = find(sum(planeBin)>0);

        planeBin = newFindPlane3D(fgCln, fgDepths, 3, 40);

        if sum(sum(planeBin)) > 0
            planeBin = getFolder(fgDepths, planeBin, 0.01, 3, 0.001);
        else
            planeBin = planeBin;
        end

        finalIm = manInIm;

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
            end
            [numlines, datalines] = newFindCorners(tr,tc,480,640,0,10);
            lengths = lineLengths(numlines, datalines);
            corners = getAllCorners(lengths, numlines, datalines, 0);
            finalIm = remapVideo(i, manInIm, corners, 0);
        end

       outputImages{i} = finalIm;
        
    end

    figure(1000);
    aviWriter(outputImages);

