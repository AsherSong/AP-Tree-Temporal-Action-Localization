%82.21
clc;clear;
filepath='L:\大四下\毕设\UCF101\UCF101\ucf101_data\final_1108\fc6-1\test\';
result=[];
train_data=load('traindata.mat');
train_data=train_data.traindata;
model=load('model.mat');
model=model.model;
right=0;
allnum=0;
for i=1:20
    disp(['第' num2str(i) '  ']);
    a=load([filepath num2str(i) '.mat']);
    seg=a.seg_num;
    allnum=allnum+size(seg,1);
    startseg=0;
    endseg=0;
    for j=1:size(seg,1)
        startseg=endseg+1;
        endseg=endseg+seg(j);
        test_feat=a.test_feat(startseg:endseg,:);
        feat_num=size(test_feat,1);
        clip=floor(feat_num/2);
        feat=[];
        for k=1:clip
            feat=[feat;test_feat(2*(k-1)+2,:)];
        end
        testlabel=ones(size(feat,1),1)*i;
        bglabel= svmpredict(testlabel,[(1:length(testlabel))',feat*train_data'],model);
        
        video=bglabel';
        AP=APscore(video);
        apscore=AP.out;
        result=[result;apscore];
        [maxd,ind]=max(apscore);
        mayid=find(apscore==maxd);
       if ismember(i,mayid)
           right=right+1;
           disp(詀ptree judge right');
           continue;
       end
       fpscore(mayid)=-1;
       [maxd,ind]=max(apscore);
       if ind==i
           right=right+1;
           disp(詀ptree judge right');
       end
%         all=sum(score,2);
%         for j=1:20
%             score(j)=score(j)/all;
%             tf=isnan(score(j));
%             if tf==1
%                 score(j)=0;
%             end
%         end
        
    end
end
save('Result.mat','result');
acc=right/allnum;


