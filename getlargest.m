% selects the largest of the connected image regions in the binary image

% Code: Robert B. Fisher

function largest = getlargest(input,show)

     if nargin == 1
        show = 0;
     end

     [label,num] = bwlabel(input,4);    % 4 connectivity labeling of regions
     if num==1                          % if only 1 region
         largest = input;
         return
     end

     % find biggest
     regiondata = regionprops(label,'Area');    % get region areas
     maxarea = max([regiondata.Area]);          % get largest area
     Ind = find([regiondata.Area]==maxarea);    % get its index

     % make output image - select the pixels with the desired index
     largest = ismember(label,Ind);

     if show > 0
        figure(show)
        colormap(gray)
        imshow(largest)
     end
