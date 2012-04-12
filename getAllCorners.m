function orderedCorners = getAllCorners(lengths, numlines, datalines, figN)

    corners = zeros(4,2);

    % First find the line that is the bottom of the box
    lowestX = max(datalines(1:numlines,1));
    line1 = find(datalines(1:numlines,1)==lowestX);
    line1 = line1(1);
    line2 = find(datalines(1:numlines,3)==lowestX);
    line2 = line2(1);

    if lengths(line1) > lengths(line2)
        line = line1;
    else
        line = line2;
    end

    corners(1,1) = datalines(line,1);
    corners(1,2) = datalines(line,2);
    corners(2,1) = datalines(line,3);
    corners(2,2) = datalines(line,4);

    % Second work out where the top corners must be
    length = lengths(line);
    yDiff = corners(2,1) - corners(1,1);
    xDiff = corners(2,2) - corners(1,2);

    if xDiff > 0
        sign = 1;
    else
        sign = -1;
    end

    corners(3,1) = corners(1,1) - abs(xDiff) * 0.9;
    corners(3,2) = corners(1,2) + yDiff * sign * 0.9;
    corners(4,1) = corners(2,1) - abs(xDiff) * 0.9;
    corners(4,2) = corners(2,2) + yDiff * sign * 0.9;

    orderedCorners = zeros(4,2);
    if xDiff > 0
        orderedCorners(1,:) = corners(3,:);
        orderedCorners(2,:) = corners(4,:);
        orderedCorners(3,:) = corners(2,:);
        orderedCorners(4,:) = corners(1,:);
    else
        orderedCorners(1,:) = corners(4,:);
        orderedCorners(2,:) = corners(3,:);
        orderedCorners(3,:) = corners(1,:);
        orderedCorners(4,:) = corners(2,:);
    end

    % Plot the corners if requested
    if figN > 0
        figure(figN)
        clf
        hold on
        for i = 1 : 3
            plot([orderedCorners(i,2), orderedCorners(i+1,2)],[orderedCorners(i,1), orderedCorners(i+1,1)],'*-')
        end   
        plot([orderedCorners(4,2), orderedCorners(1,2)],[orderedCorners(4,1), orderedCorners(1,1)],'*-')
        axis([0,640,0,480])
        axis ij
    end



