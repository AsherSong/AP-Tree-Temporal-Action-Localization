function apcreate=APcreate()

MTST=0.2;   % Minimum Term Support Threshold最小项集支持度
MMCT=0.1;    % Minimum Mode Confidence Threshold最小模式置信度

    for i=1:20
    %% Load Data

    data=load(['fpprocess/B' num2str(i) '.mat']);
    a=data.B1;
    b=data.B2;
    c=data.B3;
    d=data.B4;
    e=data.B5;
    T=[a;b;c;d;e];
    %% AP-Growth
    out=APGrowth(T,MTST,MMCT);

    %% Results

    Tree=out.Node;
    if ~exist('fpmodel')
        mkdir('fpmodel')
    end
    save(['apmodel/fp' num2str(i) '.mat'],'Tree');
    end
%     fpcreate.out=Tree;
end