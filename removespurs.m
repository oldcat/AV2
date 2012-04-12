% r,c = positions of boundary
% H,W = image height and width

function [sr,sc] = removespurs(r,c,H,W,figN)

  % recreate HxW data array with 1's at boundary positions
  work=zeros(H,W);
  N = length(r);
  for i = 1 : N
    work(r(i),c(i))=1;
  end

  numOvers = 0;
  overThrees = zeros(100,2);

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
      elseif count > 3
        numOvers = numOvers + 1;
        overThrees(numOvers,1) = sr(i);
        overThrees(numOvers,2) = sc(i);
      end
    end
  end

    for i = 1 : numOvers
        for j = 1 : numOvers
%            if abs(overThrees(j,1)-overThrees(i,1)) < 2 & abs(overThrees(j,2)-overThrees(i,2)) < 2
%                if overThrees(j,1) ~= overThrees(i,1) | overThrees(j,2) ~= overThrees(i,2)
            if abs(overThrees(j,1)-overThrees(i,1)) == 1 & overThrees(j,2) == overThrees(i,2) | abs(overThrees(j,2)-overThrees(i,2)) == 1 & overThrees(j,1) == overThrees(i,1)
                    work(overThrees(i,1),overThrees(i,2))=0;
                    work(overThrees(j,1),overThrees(j,2))=0;
%                end
            end
        end
%        neigh = work(overThrees(i,1)-1:overThrees(i,1)+1,overThrees(i,2)-1:overThrees(i,2)+1);
%        [a,b] = find(neigh==1);
%        for j = 1 : a
%            for k = 1 : b
%                %get neighbourhood of jk
%                subNeigh = work(overThrees(i,1)-1+a-2:overThrees(i,1)+1+a-2,overThrees(i,2)-1+b-2:overThrees(i,2)+1+b-2)
%                for 
%                %if all its neighbours that are in overThrees, remove it
%                if neigh(j,k);
%            end
%        end
    end

    [sr,sc] = find(work==1);
    for i = 1 : length(sr)      % check each boundary point
      neigh = work(sr(i)-1:sr(i)+1,sc(i)-1:sc(i)+1);
      count=sum(sum(neigh));
      if count < 2              % only point and at most 1 neighbor
        work(sr(i),sc(i)) = 0;  % so remove it
      end
    end

    for i = 1 : numOvers
        work(overThrees(i,1),overThrees(i,2))=1;
    end
    
    for r = 2 : H-1
        for c = 2 : W-1
            if work(r,c)==1 & work(r+1,c+1)==1
                if work(r+1,c)==1
                    work(r+1,c)=0;
                end
                if work(r,c+1)==1
                    work(r,c+1)=0;
                end
            end
            if work(r,c)==1 & work(r+1,c-1)==1
                if work(r+1,c)==1
                    work(r+1,c)=0;
                end
                if work(r,c-1)==1
                    work(r,c-1)=0;
                end
            end
        end
    end

if figN > 0
  figure(figN)
  imshow(work)
end

       
