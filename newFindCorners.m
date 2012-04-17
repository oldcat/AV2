% Modification of findcorners.m from AV website
% The difference here is that numlines and datalines are
% parameters instead of global variables and this then
% joins 2 lines together if they have a common endpoint
% and are deemed to have a similar gradient

function [numlines, datalines] = newFindCorners(r,c,H,W,figN,threshold)

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
  [numlines, datalines] = newRecSplit(setar,setac,threshold, numlines, datalines);
  [numlines, datalines] = newRecSplit(setbr,setbc,threshold, numlines, datalines);

  % get gradients
  gradients = zeros(numlines,1);
  for i = 1 : numlines
    x1 = datalines(i,1);
    y1 = datalines(i,2);
    x2 = datalines(i,3);
    y2 = datalines(i,4);
    gradients(i) = (y2-y1)/(x2-x1);
  end

  % smooth results by merging lines with a common point and similar gradient
  notdone = true;
  while (notdone)
    notdone = false;
    for i = 1 : numlines-1
      comparison = gradients(i)/gradients(i+1);
      if comparison < 1.75 & comparison > 0.25
          datalines(i,3:4) = datalines(i+1,3:4);
          datalines(i+1,:) = [];
          gradients(i) = (datalines(i,4)-datalines(i,2))/(datalines(i,3)-datalines(i,1));
          gradients(i+1) = [];
          numlines = numlines-1;
          notdone = true;
          break;
      end
    end
    if datalines(numlines,3)==datalines(1,1) & datalines(numlines,4)==datalines(1,2)
      comparison = gradients(numlines)/gradients(1);
      if comparison < 1.75 & comparison > 0.25
          datalines(1,1:2) = datalines(numlines,1:2);
          datalines(numlines,:) = [];
          gradients(1) = (datalines(1,4)-datalines(1,2))/(datalines(1,3)-datalines(1,1));
          gradients(numlines) = [];
          numlines = numlines-1;
          notdone = true;
          break;
      end
    end
  end

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
