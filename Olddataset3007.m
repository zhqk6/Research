close all;
clear all;
Term={'acty', 'anst', 'antb', 'bacs', 'bdsu', 'bdsy', 'bhvr', 'biof', 'blor', 'bpoc', 'bsoj', 'clna', 'clnd', 'diap', 'dsyn', 'dora', 'edac', 'evnt', 'fndg', 'hlca', 'inbe', 'lbtr', 'medd', 'menp', 'mobd', 'npop',  'orch', 'orgf', 'patf', 'phsf', 'phsu', 'socb', 'sosy', 'topp'};
% load('Resident3003.mat');
% load('Resident3004.mat');
load('Resident3007.mat');
% [number1,txt1,raw1]=xlsread('3003_all_data_per_hour.xls');
% [number2,txt2,raw2]=xlsread('3004_all_data_per_hour.xls');
[number3,txt3,raw3]=xlsread('3007_all_data_per_hour.xls'); 
space=cell(1,1);
for i=1:402
    %     if isequal(table3007(i,3),table3007(i-1,3)) && ~isempty(table3007(i-1,5))
    %         table3007(i-1,5)=strcat(table3007(i-1,5),table3007(i,5));
    %         table3007(i,5)=space;
    %     end
    %     if isequal(table3007(i,3),table3007(i-1,3)) && isempty(table3007(i-1,5))
    %         table3007(i-1,5)=strcat(table3007(i-1,5),table3007(i,5));
    %         table3007(i,5)=space;
    %     end
    for j=1:402
        if i~=j && isequal(table3007(i,3),table3007(j,3))
            table3007(i,5)=strcat(table3007(i,5),table3007(j,5));
            table3007(j,5)=space;
        end
    end
end
for i=1:402
    if isequal(table3007(i,5),space)
        table3007(i,:)=space;
    end
end
ans2=table3007(~cellfun('isempty',table3007));
update_table3007=cell(237,38);
for i=1:236
    update_table3007(i+1,1)=ans2(i+237*2);
    update_table3007(i+1,2)=ans2(i+237*4);
end
update_table3007(1,1)=cellstr('date');
update_table3007(1,2)=cellstr('Semantic types and terms');
update_table3007(1,37)=cellstr('total');
update_table3007(1,38)=cellstr('abnormality');

for i=2:237
    colon=strfind(update_table3007(i,2),':');
    semicolon=strfind(update_table3007(i,2),';');
    colon_mat=cell2mat(colon);
    semicolon_mat=cell2mat(semicolon);
    table_mat=cell2mat(update_table3007(i,2));
    for j=1:length(colon_mat)
        word=table_mat((colon_mat(j)+1):(semicolon_mat(j)-1));
        if (length(strfind(table_mat,word))==1)||(word(1)=='0')
            continue;
        end
        index=cell2mat(strfind(update_table3007(i,2),word));
        if length(index)~=1
            term_set=cell(1,length(index));
            for k=1:length(index)
                term_set(k)=cellstr(table_mat((index(k)-5):(index(k)-2)));
            end
            term=set_priority(term_set);
            remaining_index=[];
            for k=1:length(index)
                if isequal(cellstr(table_mat((index(k)-5):(index(k)-2))),term)
                    remaining_index=[remaining_index (index(k)-5):(index(k)+length(word)+1)];
                    break;
                end
            end
            table_mat([(index(1)-5):(remaining_index(1)-1) (remaining_index(end)+1):(index(end)+length(word))])='0';
        end
    end
    table_mat(table_mat=='0')=[];
    update_table3007(i,2)=cellstr(table_mat);
end


for i=3:36
    update_table3007(1,i)=Term(i-2);
end
for i=2:237
    for j=1:34
        ans3=strfind(update_table3007(i,2),Term(j));
        if isequal(ans3,space)
        update_table3007(i,2+j)=num2cell(0);  
        else
        num=length(cell2mat(ans3));
        update_table3007(i,2+j)=num2cell(num);
        end
    end
end

for i=2:237
    sum=0;
    for j=3:36
        if ~isequal(cell2mat(update_table3007(i,j)),0)
        sum=cell2mat(update_table3007(i,j))+sum;
        end
    end
    update_table3007(i,37)=num2cell(sum);
end

for i=2:237
    for j=2:11980
        if isequal(raw3(j,1),update_table3007(i,1))
            update_table3007(i,38)=raw3(j,8);
        end
    end
end

vect=zeros(236,34);
for i=2:237
    vect(i-1,:)=cell2mat(update_table3007(i,3:36));
end






% table3003(10,5)=strcat(table3003(10,5),table3003(11,5));
% table3003(11,:)=space;
% table3003(12,:)=space;
% table3003(14,5)=strcat(table3003(14,5),table3003(15,5));
% table3003(15,:)=space;
% table3003(18,5)=strcat(table3003(18,5),table3003(19,5));
% table3003(19,:)=space;
% table3003(20,5)=strcat(table3003(20,5),table3003(21,5));
% table3003(21,:)=space;
% table3003(23,5)=strcat(table3003(23,5),table3003(24,5));
% table3003(24,:)=space;
% table3003(25,5)=strcat(table3003(25,5),table3003(26,5));
% table3003(26,:)=space;
% table3003(29,5)=strcat(table3003(29,5),table3003(30,5));
% table3003(30,:)=space;
% table3003(32,5)=strcat(table3003(32,5),table3003(33,5),table3003(34,5),table3003(35,5));
% table3003(33,:)=space;
% table3003(34,:)=space;
% table3003(35,:)=space;
% table3003(37,5)=strcat(table3003(37,5),table3003(38,5));
% table3003(38,:)=space;
% table3003(39,5)=strcat(table3003(39,5),table3003(40,5));
% table3003(40,:)=space;
% table3003(41,5)=strcat(table3003(41,5),table3003(42,5),table3003(43,5));
% table3003(42,:)=space;
% table3003(43,:)=space;
% table3003(45,5)=strcat(table3003(45,5),table3003(46,5),table3003(47,5));
% table3003(46,:)=space;
% table3003(47,:)=space;
% table3003(49,5)=strcat(table3003(49,5),table3003(50,5));
% table3003(50,:)=space;
% table3003(52,5)=strcat(table3003(52,5),table3003(53,5));
% table3003(53,:)=space;
% table3003(54,:)=space;
% table3003(62,5)=strcat(table3003(62,5),table3003(63,5));
% table3003(63,:)=space;
% 
% ans1=table3003(~cellfun('isempty',table3003));
% update_table3003=cell(55,38);
% for i=1:54
%     update_table3003(i+1,1)=ans1(i+54*2);
%     update_table3003(i+1,2)=ans1(i+54*4);
% end
% 
% update_table3003(1,1)=cellstr('date');
% update_table3003(1,2)=cellstr('Semantic types and terms');
% update_table3003(1,37)=cellstr('total');
% update_table3003(1,38)=cellstr('abnormality');

% for i=3:36
%     update_table3003(1,i)=Term(i-2);
% end
% 
% 
% for i=2:55
%     for j=1:34
%         ans2=strfind(update_table3003(i,2),Term(j));
%         if isequal(ans2,space)
%         update_table3003(i,2+j)=num2cell(0);  
%         else
%         num=length(cell2mat(ans2));
%         update_table3003(i,2+j)=num2cell(num);
%         end
%     end
% end
% 
% for i=2:55
%     sum=0;
%     for j=3:36
%         if ~isequal(cell2mat(update_table3003(i,j)),0)
%         sum=cell2mat(update_table3003(i,j))+sum;
%         end
%     end
%     update_table3003(i,37)=num2cell(sum);
% end
% 
% for i=2:55
%     for j=2:10585
%         if isequal(raw1(j,1),update_table3003(i,1))
%             update_table3003(i,38)=raw1(j,8);
%         end
%     end
% end
% 
% vect=zeros(54,34);
% for i=2:55
%     vect(i-1,:)=cell2mat(update_table3003(i,3:36));
% end