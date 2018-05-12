clear all;
load('olddataset_table_3007_PR_revised.mat');
[number3,txt3,raw3]=xlsread('3007_all_data_per_hour.xls'); 
space=cell(1,1);
one_col=cell(137,1);
one_raw=cell(1,39);
k=1;
update_table3007=olddataset_table_3007_PR_revised;
for i=2:length(update_table3007)
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
    if  m<101 && isequal(raw3(i,8),num2cell(0))
        update_table3007=[update_table3007;one_raw];
        update_table3007(137+m,1)=raw3(i,1);
        m=m+1;
    end
end

for i=138:237
    for j=3:39
        update_table3007(i,j)=num2cell(0);
    end
end

for i=2:237
    if isequal(update_table3007(i,39),num2cell(0))
        update_table3007(i,37)=num2cell(1);
    else
        update_table3007(i,37)=num2cell(0);
    end
end
update_table3007([11 137],:)=update_table3007([137 11],:);



constant_dayback=30;
PR_table=cell(238,61);
for i=1:30
    PR_table(1,i*2)=cellstr(sprintf('%s%d','P',i));
    PR_table(1,i*2+1)=cellstr(sprintf('%s%d','R',i));
end
PR_table(1:237,1)=update_table3007(:,1);
PR_table(238,1)=cellstr('average');

update_table3007=[update_table3007;update_table3007(2:31,:)];

for i=2:237
    Precision=zeros(30,1);
    Recall=zeros(30,1);
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
for i=2:61
    PR_table(238,i)=num2cell(sum(cell2mat(PR_table(2:237,i)))/236);
end
% update_table3007([2 54],:)=update_table3007([54 2],:);
% %change here to see all the days 


% PR_table=cell(41,21);
% PR_table(1,2:21)={'D1','D2','D3','D4','D5','D6','D7','D8','D9','D10','D11','D12','D13','D14','D15','D16','D17','D18','D19','average'};
% PR_table(2:41,1)={'P1','R1','P2','R2','P3','R3','P4','R4','P5','R5','P6','R6','P7','R7','P8','R8','P9','R9','P10','R10','P11','R11','P12','R12','P13','R13','P14','R14','P15','R15','P16','R16','P17','R17','P18','R18','P19','R19','P20','R20'};
% 
% Precision=zeros(19,1);
% Recall=zeros(19,1);

% for i=1:20
%     if i==1
%         [Precision(1),Recall(1)]=compute_PR(cell2mat(update_table3007(2,3:37)),cell2mat(update_table3007(3,3:37)));
%         for j=2:19
%             [Precision(j),Recall(j)]=compute_PR(cell2mat(update_table3007(2,3:37)),sum(cell2mat(update_table3007(3:j+2,3:37))));
%         end
%         PR_table(i*2,2:20)=num2cell(Precision);
%         PR_table(i*2+1,2:20)=num2cell(Recall);
%     else
%         update_table3007([2 i+1],:)=update_table3007([i+1 2],:);
%         [Precision(1),Recall(1)]=compute_PR(cell2mat(update_table3007(2,3:37)),cell2mat(update_table3007(3,3:37)));
%         for j=2:19
%             [Precision(j),Recall(j)]=compute_PR(cell2mat(update_table3007(2,3:37)),sum(cell2mat(update_table3007(3:j+2,3:37))));
%         end
%         PR_table(i*2,2:20)=num2cell(Precision);
%         PR_table(i*2+1,2:20)=num2cell(Recall);
%         update_table3007([2 i+1],:)=update_table3007([i+1 2],:);
%     end
% end
% for i=2:41
%     PR_table(i,21)=num2cell(sum(cell2mat(PR_table(i,2:20)))/19);
% end

% Precision=zeros(235,1);
% Recall=zeros(235,1);
% [Precision(1),Recall(1)]=compute_PR(cell2mat(update_table3007(2,3:37)),cell2mat(update_table3007(3,3:37)));
%  update_table3007(3,40)=num2cell(Precision(1));
%  update_table3007(3,41)=num2cell(Recall(1));
% for i=4:237
% [Precision(i-2),Recall(i-2)]=compute_PR(cell2mat(update_table3007(2,3:37)),sum(cell2mat(update_table3007(3:i,3:37))));
%  update_table3007(i,40)=num2cell(Precision(i-2));
%  update_table3007(i,41)=num2cell(Recall(i-2));
% end
aver_P=zeros(1,30);
aver_R=zeros(1,30);

for i=1:30
    aver_P(i)=cell2mat(PR_table(238,i*2));
    aver_R(i)=cell2mat(PR_table(238,i*2+1));
end
figure;
plot(aver_P,aver_R,'-.ob','LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','b',...
    'MarkerSize',5);
text(aver_P(1),aver_R(1),'day1','FontSize',20);
text(aver_P(17),aver_R(17),'day17','Color','red','FontSize',20);
text(aver_P(30),aver_R(30),'day30','FontSize',20);
axis([0.5 1 0 1]);
xlabel('Precision','FontSize',20);
ylabel('Recall','FontSize',20);
title('Resident 3007 30 days back PR-curve','FontSize',20);
figure;
Y=diff(aver_P);
bar(Y,0.2);
xlabel('day intervals','FontSize',20);
ylabel('difference of precision between 2 days','FontSize',20);
title('differences for resident 3007','FontSize',20);