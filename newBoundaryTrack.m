% Modification of boundarytrack.m from the AV website
% Difference to original boundarytrack is that this cuts off pixels
% that are not in the loop (assuming the boundary will at some point
% reach a pixel somewhere in the 3x3 grid around a previous pixel)

function [tr,tc] = myBoundaryTrack(r,c,H,W,figN)

  % next direction offsets
  % 1 2 3
  % 8 x 4
  % 7 6 5
  mr = [-1,-1,-1,0,1,1,1,0];
  mc = [-1,0,1,1,1,0,-1,-1];
  
  % set up visited array (keep track of where we have already tracked)
  
  n = length(r);
  visited=zeros(H,W);
  for i = 1 : n
    visited(r(i),c(i)) = 1;
  end

  allPoints = visited;

  % set up tracked output
  
  tmpr = zeros(n,1);
  tmpc = zeros(n,1);
  count = 1;
  tmpr(1) = r(1);
  tmpc(1) = c(1);
  visited(tmpr(count),tmpc(count)) = 0;


  % find first connected point clockwise
  
  lastdir = 1;  % arbitrary start
  notdone = 1;

  finalr = 0;
  finalc = 0;

  while notdone
    
    % find next untracked point
    
    notdone = 0;
    for i = 1 : 8                       % try all 8 directions
      nextdir = lastdir + 4 + i;        % get next direction to try
      while nextdir > 8
        nextdir = nextdir - 8;
      end

      % see if nextdir is a boundary point
      nr = tmpr(count)+mr(nextdir);
      nc = tmpc(count)+mc(nextdir);

      if visited(nr,nc) == 1
        % it is a boundary point, so track to it
        lastdir = nextdir;
        notdone = 1;
        count = count + 1;
        tmpr(count) = nr;
        tmpc(count) = nc;
        visited(nr,nc) = 0;
        break
      elseif allPoints(nr,nc) == 1 & ~(nr==tmpr(count-1) & nc==tmpc(count-1))
      % If this is a point in the boundary that has been visited and wasn't visited previously
        finalr = nr;
        finalc = nc;
      end
    end
  end
  tr = tmpr(1:count);
  tc = tmpc(1:count);

  startInd = find(tr==finalr & tc==finalc);
  tr = tr(startInd:count);
  tc = tc(startInd:count);

% display result - ?
  
if figN > 0
  figure(figN)
  plot(tc,tr)
  axis([0,W,0,H])
  axis ij
end

      
