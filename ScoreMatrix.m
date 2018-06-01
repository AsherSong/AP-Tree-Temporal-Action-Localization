function ScoreMatrix=ScoreMatrix()
temp=[];
class=20;
mainmode={};
for i=1:class
    aptree=load([‘apmodel/fp' num2str(i) '.mat']);
    aptree=aptree.Tree;
    a=numel(aptree)-1;
    temp=[temp;a];
end
m=max(temp);
score=zeros(m+1,class);
for i=1:class
    aptree=load([‘apmodel/fp' num2str(i) '.mat']);
    aptree=aptree.Tree;
    
    for j=2:numel(aptree)
        tf=ismember(i,aptree(j).Path);
        
        if tf==1
            score(j-1,i)=1;
        else
            score(j-1,i)=aptree(j).Count/aptree(1).Count;
        end
        
    end
    score(m+1,i)= -0.2;
    %     mainmode=[mainmode;mark];
end
% save('mainmode.mat','mainmode');
ScoreMatrix.out=score;
ScoreMatrix.m=m;
end