% Modification of recsplit.m from AV website
% Difference is simply numlines and datalines passed as arguments instead of
% global variables

function [numlines, datalines] = recsplit(r,c,threshold, numlines, datalines)

  n = length(r);
  vec = [c(n)-c(1), r(1)-r(n)];  % perpendicular vector
  vec = vec/norm(vec);

  % find point furthest from line
  maxdist = 0;
  for i = 1 : n
    dist = abs( [r(i) - r(1), c(i) - c(1)] * vec' );
    if dist > maxdist
      maxdist = dist;
      maxindex = i;           % where furthest
    end
  end

  % check for splitting
  if maxdist < threshold
    % then it's a single line - save it
    numlines = numlines + 1;
    datalines(numlines,1) = r(1);
    datalines(numlines,2) = c(1);
    datalines(numlines,3) = r(n);
    datalines(numlines,4) = c(n);
  else
%split=[maxindex, r(maxindex), r(1), c(maxindex), c(1), maxdist]
%vec
    % otherwise it needs to be split up
    [numlines, datalines] = newRecSplit(r(1:maxindex),c(1:maxindex),threshold,numlines,datalines);
    [numlines, datalines] = newRecSplit(r(maxindex:n),c(maxindex:n),threshold,numlines,datalines);
  end
