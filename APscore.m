function APscore=APscore(video)
class=20;

Score=ScoreMatrix();
scorematrix=Score.out;

Mode=ModeMatrix(video);
modematrix=Mode.out;

apscore=[];
tempscore=modematrix*scorematrix;
for i=1:class
    apscore=[apscore,tempscore(i,i)];
end
apscore=apscore/length(video);

APscore.out=fpscore;
end