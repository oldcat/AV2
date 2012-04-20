function idealMain()

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
        fgCln = myCleanup(fgBin,2,3);
        
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

        finalIm = manInIm;

        corners = zeros(4,2);
        if i==14
            corners(1,1) = 314;
            corners(1,2) = 46;
            corners(2,1) = 329;
            corners(2,2) = 155;
            corners(3,1) = 436;
            corners(3,2) = 136;
            corners(4,1) = 418;
            corners(4,2) = 14;
        elseif i == 15
            corners(1,1) = 323;
            corners(1,2) = 106;
            corners(2,1) = 322;
            corners(2,2) = 222;
            corners(3,1) = 428;
            corners(3,2) = 218;
            corners(4,1) = 427;
            corners(4,2) = 91;
        elseif i == 16
            corners(1,1) = 321;
            corners(1,2) = 177;
            corners(2,1) = 292;
            corners(2,2) = 287;
            corners(3,1) = 391;
            corners(3,2) = 312;
            corners(4,1) = 425;
            corners(4,2) = 199;
        elseif i == 17
            corners(1,1) = 319;
            corners(1,2) = 226;
            corners(2,1) = 286;
            corners(2,2) = 328;
            corners(3,1) = 381;
            corners(3,2) = 360;
            corners(4,1) = 418;
            corners(4,2) = 252;
        elseif i == 18
            corners(1,1) = 320;
            corners(1,2) = 220;
            corners(2,1) = 311;
            corners(2,2) = 324;
            corners(3,1) = 410;
            corners(3,2) = 336;
            corners(4,1) = 419;
            corners(4,2) = 224;
        elseif i == 19
            corners(1,1) = 322;
            corners(1,2) = 212;
            corners(2,1) = 324;
            corners(2,2) = 316;
            corners(3,1) = 426;
            corners(3,2) = 312;
            corners(4,1) = 422;
            corners(4,2) = 198;
        elseif i == 20
            corners(1,1) = 312;
            corners(1,2) = 208;
            corners(2,1) = 333;
            corners(2,2) = 307;
            corners(3,1) = 432;
            corners(3,2) = 284;
            corners(4,1) = 406;
            corners(4,2) = 177;
        elseif i == 21
            corners(1,1) = 314;
            corners(1,2) = 256;
            corners(2,1) = 333;
            corners(2,2) = 360;
            corners(3,1) = 435;
            corners(3,2) = 344;
            corners(4,1) = 412;
            corners(4,2) = 231;
        elseif i == 22
            corners(1,1) = 318;
            corners(1,2) = 319;
            corners(2,1) = 329;
            corners(2,2) = 426;
            corners(3,1) = 431;
            corners(3,2) = 424;
            corners(4,1) = 419;
            corners(4,2) = 308;
        elseif i == 23
            corners(1,1) = 324;
            corners(1,2) = 382;
            corners(2,1) = 321;
            corners(2,2) = 491;
            corners(3,1) = 423;
            corners(3,2) = 508;
            corners(4,1) = 431;
            corners(4,2) = 391;
        elseif i == 24
            corners(1,1) = 327;
            corners(1,2) = 451;
            corners(2,1) = 297;
            corners(2,2) = 555;
            corners(3,1) = 390;
            corners(3,2) = 599;
            corners(4,1) = 424;
            corners(4,2) = 485;
        elseif i == 25
            corners(1,1) = 324;
            corners(1,2) = 470;
            corners(2,1) = 304;
            corners(2,2) = 574;
            corners(3,1) = 396; % guess
            corners(3,2) = 609; % guess
            corners(4,1) = 422;
            corners(4,2) = 493;
        elseif i == 26
            corners(1,1) = 326;
            corners(1,2) = 466;
            corners(2,1) = 323;
            corners(2,2) = 572;
            corners(3,1) = 419;
            corners(3,2) = 589;
            corners(4,1) = 423;
            corners(4,2) = 474;
        elseif i == 27
            corners(1,1) = 317;
            corners(1,2) = 451;
            corners(2,1) = 332;
            corners(2,2) = 560;
            corners(3,1) = 423;
            corners(3,2) = 558;
            corners(4,1) = 411;
            corners(4,2) = 443;
        elseif i == 28
            corners(1,1) = 310;
            corners(1,2) = 481;
            corners(2,1) = 335;
            corners(2,2) = 587;
            corners(3,1) = 428;
            corners(3,2) = 578;
            corners(4,1) = 402;
            corners(4,2) = 459;
        end

        finalIm = zeros(480,640,3);
        if (corners(1,1)>0)
            finalIm = remapVideo(i, finalIm, corners, i);
        end

        outputImages{i} = finalIm;
        imwrite(finalIm, ['~/Desktop/AV2/QuadBinaries/' sprintf('%04d', i) '.jpg'],'jpg');
        
    end

    figure(1000);
%    aviWriter(outputImages);

