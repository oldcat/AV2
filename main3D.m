function main()

    [bgDepths, bgIm] = getBackground;

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
        
        %newPlaneBin = findPlane(planeBin);
         
         
        %figure(i) 
        %imshow(manInIm)
        %figure(i+36)
        %imshow(myCleanup(planeBin,4,4))
        %figure(i+72)
        %imshow(myCleanup(better>0.94,0,2))
       
end

% imwrite(planeBin,'~/Desktop/AV2/planeBin.jpg','jpg');
