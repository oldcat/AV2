% Calculates the length of each line in datalines

function lengths = lineLengths(numlines, datalines)

    lengths = zeros(numlines,1);
    for i = 1 : numlines
        if datalines(i,1) ~= 0 | datalines(i,2) ~= 0 | datalines(i,3) ~= 0 | datalines(i,4) ~= 0
            x1 = datalines(i,1);
            y1 = datalines(i,2);
            x2 = datalines(i,3);
            y2 = datalines(i,4);
            lengths(i) = sqrt((x2-x1).^2 + (y2-y1).^2);
        end
    end
            



