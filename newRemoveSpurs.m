% Modification of removespurs.m from the AV website
% The difference here is extra conditions for removing
% pixels as the function was removing pixels it should
% not have been.

function [sr,sc] = newRemoveSpurs(r,c,H,W,figN)

  % recreate HxW data array with 1's at boundary positions

  work=zeros(H,W);
  N = length(r);
  for i = 1 : N
    work(r(i),c(i))=1;
  end

  % remove unecessary pixels (as discussed in lectures)
  
  for r = 3 : H-2
  for c = 3 : W-2
    if work(r,c)==1 & work(r+1,c+1)==1
      if work(r+1,c)==1 & (work(r+1,c-1)==0 & work(r+2,c-1)==0 & work(r+2,c)==0)
        work(r+1,c)=0;
      end
      if work(r,c+1)==1 & (work(r-1,c+1)==0 & work(r-1,c+2)==0 & work(r,c+2)==0)
        work(r,c+1)=0;
      end
    end
    if work(r,c)==1 & work(r+1,c-1)==1
      if work(r+1,c)==1 & (work(r+1,c+1)==0 & work(r+2,c+1)==0 & work(r+2,c)==0)
        work(r+1,c)=0;
      end
      if work(r,c-1)==1 & (work(r-1,c-1)==0 & work(r-1,c-2)==0 & work(r,c-2)==0)
        work(r,c-1)=0;
      end
    end
  end
  end

  % check for other dangling spurs (as discussed in lectures)
  
  changed=1;
  while changed==1
    changed = 0;
    [sr,sc] = find(work==1);
    for i = 1 : length(sr)      % check each boundary point
      neigh = work(sr(i)-1:sr(i)+1,sc(i)-1:sc(i)+1);
      count=sum(sum(neigh));
      if count < 3              % only point and at most 1 neighbor
        work(sr(i),sc(i)) = 0;  % so remove it
        changed=1;
      end
    end
  end

% display result - ?
  
if figN > 0
  figure(figN)
  clf
  plot(sc,sr,'.')
  axis ij
  axis([0,W,0,H])
end

       
