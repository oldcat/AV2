function main2D()

    [bgDepths, bgIm] = getBackground;
    outputImages = cell(36);

    for i = 1:36
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
           
        planeBin = getlargest(myCleanup(better>0.94,0,2));
        finalIm = manInIm;

        if (getArea(planeBin)>50)
            [r,c] = find(bwperim(planeBin,4)==1);
            % Do not need to remove spurs as when gelargest was used earlier,
            % it looked for 4 connectivity, so no dangling spurs on image.
            [tr,tc] = boundarytrack(r,c,480,640,0);
            [numlines, datalines] = findcorners(tr,tc,480,640,0,10);
            lengths = lineLengths(numlines, datalines);
            corners = getAllCorners(lengths, numlines, datalines, 0);
            finalIm = remapVideo(manInIm, corners, i);
        end

        %figure(i)
        %imshow(manInIm)
        %figure(i+36)
        %imshow(myCleanup(planeBin,4,4))
        %figure(i+72)
        %imshow(myCleanup(better>0.94,0,2))

       outputImages{i} = finalIm;
    end

    aviWriter(outputImages);

% imwrite(planeBin,'~/Desktop/AV2/planeBin.jpg','jpg');
