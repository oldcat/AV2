% results returned in datalines, numlines global variables

% r,c = positions of boundary
% H,W = image height and width
% figN = figure number for result display (0 for no display)
% threshold = distance threshold for line fitting in recursive split 
% algorithm

function [numlines, datalines] = findcorners(r,c,H,W,figN,threshold)

  numlines = 0;
  datalines = zeros(100,4);

  % assumes (r,c) are lists of consecutive boundary points
  as = find(c==min(c));         % left start point
  inda = as(1);                 % index
  bs = find(c==max(c));         % right start point
  indb = bs(1);                 % index
  sta = min(inda,indb);         % sort into order
  stb = max(inda,indb);

  % split into two initial sets
  n = length(c);
  setar = r(sta:stb);           % set a
  setac = c(sta:stb);
  blen = n - (stb-sta) + 1;     % set b
  setbr=zeros(blen,1);
  setbc=zeros(blen,1);
  setbr(1:n-stb+1) = r(stb:n);
  setbc(1:n-stb+1) = c(stb:n);
  setbr(n-stb+2:blen) = r(1:sta);
  setbc(n-stb+2:blen) = c(1:sta);

  % recursive split on each of the two sets
  [numlines, datalines] = recsplit(setar,setac,threshold, numlines, datalines);
  [numlines, datalines] = recsplit(setbr,setbc,threshold, numlines, datalines);

  if figN > 0
    figure(figN)
    clf
    hold on
    for i = 1 : numlines
      plot([datalines(i,2),datalines(i,4)],[datalines(i,1),datalines(i,3)],'*-')
    end   
    axis([0,W,0,H])
    axis ij
  end
