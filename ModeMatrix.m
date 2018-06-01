function Mode=ModeMatrix(video)
class=20;
Score=ScoreMatrix();
m=Score.m;
mode=zeros(class,m+1);%Ä¿±ê¾ØÕó
for k=1:class
    f=load(['apmodel/fp' num2str(k) '.mat']);
    node=f.Tree;
    match=APmatch(video,node);
    nonum=match.nonum;
    match=match.mode;

    mode(k,1:length(match))=match;
    mode(k,m+1)=nonum;
%     mode(k,m+1)=0;
end
Mode.out=mode;
end