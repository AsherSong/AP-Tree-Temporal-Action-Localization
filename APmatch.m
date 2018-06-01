function match=APmatch(video,node)
str=video;
pattern=node;
mode=[];
path={};for i=1:numel(pattern)-1
    path=[path;pattern(i+1).Path];
end

%     %%%ÕÒmode
for i=1:numel(pattern)-1
    if numel(pattern(i+1).Path) ==1
        index=find(pattern(i+1).Path==str);
        num=numel(index);
        mode=[mode;num];
        continue;
    end
    if numel(pattern(i+1).Path)>1
        seq=pattern(i+1).Path;
        [tf,ind]=ismember(seq,str);
        if length(find(tf==0))==0
            continue;
        else
            num=[];
            for j=1:numel(seq)
                num=[num;length(find(seq(j)==str))];
            end
            mode=[mode;min(num)];
        end
    end
end
nonum=0;
for i=1:length(str)
    aa=[];
    for j=1:numel(path)
        temp=cell2mat(path(j));
        aa=[aa;ismember(str(i),temp)];
    end
    if sum(aa)==0
        nonum=nonum+1;
    end
end

match.mode=mode;
match.nonum=nonum;
end