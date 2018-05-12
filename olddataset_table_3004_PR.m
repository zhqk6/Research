clear all;
load('olddataset_table_3004_PR_revised.mat');
[number3,txt3,raw3]=xlsread('3004_all_data_per_hour.xls'); 
space=cell(1,1);
one_col=cell(22,1);
one_raw=cell(1,39);
k=1;
update_table3007=update_table3004;
for i=2:23
    if isequal(space,update_table3007(i,38))
       index(k)=i;
       k=k+1;
    end
end
update_table3007(index,:)=[];
update_table3007=[update_table3007 one_col];
update_table3007(1,39)=cellstr('normal');
update_table3007(:,[39,37])=update_table3007(:,[37,39]);
update_table3007(:,[38,39])=update_table3007(:,[39,38]);

m=1;
for i=819:24:length(raw3)     
    if  m<21 && isequal(raw3(i,8),num2cell(0))
        update_table3007=[update_table3007;one_raw];
        update_table3007(22+m,1)=raw3(i,1);
        m=m+1;
    end
end

for i=23:42
    for j=3:39
        update_table3007(i,j)=num2cell(0);
    end
end

for i=2:42
    if isequal(update_table3007(i,39),num2cell(0))
        update_table3007(i,37)=num2cell(1);
    else
        update_table3007(i,37)=num2cell(0);
    end
end
% update_table3007([11 137],:)=update_table3007([137 11],:);
% dataset3007PR.Terms=update_table3007;
% one_col2=cell(237,1);
% update_table3007=[update_table3007 one_col2 one_col2];
% update_table3007(1,40)=cellstr('P');
% update_table3007(1,41)=cellstr('R');
% 
constant_dayback=20;
PR_table=cell(43,41);
for i=1:20
    PR_table(1,i*2)=cellstr(sprintf('%s%d','P',i));
    PR_table(1,i*2+1)=cellstr(sprintf('%s%d','R',i));
end
PR_table(1:42,1)=update_table3007(:,1);
PR_table(43,1)=cellstr('average');

update_table3007=[update_table3007;update_table3007(2:22,:)];

for i=2:42
    Precision=zeros(20,1);
    Recall=zeros(20,1);
    for j=1:constant_dayback
        if j==1
           [Precision(1),Recall(1)]=compute_PR(cell2mat(update_table3007(i,3:37)),cell2mat(update_table3007(i+1,3:37)));
        else
           [Precision(j),Recall(j)]=compute_PR(cell2mat(update_table3007(i,3:37)),sum(cell2mat(update_table3007((i+1):(i+j),3:37))));
        end
        PR_table(i,j*2)=num2cell(Precision(j));
        %Precision
        PR_table(i,j*2+1)=num2cell(Recall(j));
        %Recall
    end
end
for i=2:41
    PR_table(43,i)=num2cell(sum(cell2mat(PR_table(2:42,i)))/41);
end

aver_P=zeros(1,20);
aver_R=zeros(1,20);

for i=1:20
    aver_P(i)=cell2mat(PR_table(43,i*2));
    aver_R(i)=cell2mat(PR_table(43,i*2+1));
end
figure;
plot(aver_P,aver_R,'-.ob','LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','b',...
    'MarkerSize',5);
text(aver_P(1),aver_R(1),'day1','FontSize',20);
text(aver_P(8),aver_R(8),'\leftarrow day8','Color','red','FontSize',20);
text(aver_P(20),aver_R(20),'day20','FontSize',20);
axis([0.5 1 0 1]);
xlabel('Precision','FontSize',20);
ylabel('Recall','FontSize',20);
title('Resident 3004 20 days back PR-curve','FontSize',20);
figure;
Y=diff(aver_P);
bar(Y,0.2);
xlabel('day intervals','FontSize',20);
ylabel('difference of precision between 2 days','FontSize',20);
title('differences for resident 3004','FontSize',20);