clear; clc;
trainpath = ['L:\大四下\毕设\UCF101\UCF101\data\train\'];
testpath = ['L:\大四下\毕设\UCF101\UCF101\data\test\'];
rate=0.8;%train和test的比例
class=20;%类别数

traindata =[];
trainlabel = [];
testdata = [];
testlabel = [];
index={};
if ~exist('fpprocess')
    mkdir('fpprocess')
end
for i = 1:class
    dir1=dir([trainpath num2str(i) '\']);
    num=length(dir1)-2;
    ind=randperm(num);
    trainnum=ceil(num*rate);
    ind1=ind(trainnum+1:end);
    index=[index;ind1];
    for j=1:trainnum
        a = load([trainpath num2str(i) '\' num2str(ind(j)) '.mat']);
        feat=a.traindata;
        feat=mean(feat);
        traindata=[traindata;feat];
        trainlabel=[trainlabel;i];
        disp(['load ' num2str(i) ' class ' num2str(j) ' train data!']);
    end
end
model = svmtrain(trainlabel,[(1:size(traindata,1))',traindata*traindata'],'-t 4 -c 1');
for i=1:class
    B4={};
    ind2=index{i};
    for j=1:length(ind2)
        a = load([trainpath num2str(i) '\' num2str(ind2(j)) '.mat']);
        testdata=a.traindata;
        testlabel=ones(size(testdata,1),1)*i;
        [label,b,c] = svmpredict(testlabel,[(1:length(testlabel))',testdata*traindata'],model);
        A=num2cell(label',2);
        B4=[B4;A];
        disp(['load ' num2str(i) ' class ' num2str(j) ' test data!']);
    end
    savepath=['fpprocess/B' num2str(i) '.mat' ];
    save(savepath,'B4','-append');%-append追加
end

