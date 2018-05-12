load('update_table3003.mat');
load('update_table3004.mat');
load('update_table3007.mat');
update_table3003(40,:)=[];
update_table3004(23,:)=[];
[number1,txt1,raw1]=xlsread('3003_all_data_per_hour.xls'); 
[number2,txt2,raw2]=xlsread('3004_all_data_per_hour.xls'); 
[number3,txt3,raw3]=xlsread('3007_all_data_per_hour.xls');

Restless_motion3003=zeros(48,length(update_table3003)-1);
Restless_motion3004=zeros(48,length(update_table3004)-1);
Restless_motion3007=zeros(48,length(update_table3007)-1);

for i=2:length(update_table3003)
    for j=2:24:length(raw1)
        if isequal(raw1(j,1),update_table3003(i,1))
            for k=1:24
                Restless_motion3003(k,i-1)=cell2mat(raw1(j+k-1,4));
                Restless_motion3003(k+24,i-1)=cell2mat(raw1(j+k-1,3));
            end
        end
    end
end
for i=2:length(update_table3004)
    for j=2:24:length(raw2)
        if isequal(raw2(j,1),update_table3004(i,1))
            for k=1:24
                Restless_motion3004(k,i-1)=cell2mat(raw2(j+k-1,4));
                Restless_motion3004(k+24,i-1)=cell2mat(raw2(j+k-1,3));
            end
        end
    end
end
for i=2:length(update_table3007)
    for j=2:24:length(raw3)
        if isequal(raw3(j,1),update_table3007(i,1))
            for k=1:24
                Restless_motion3007(k,i-1)=cell2mat(raw3(j+k-1,4));
                Restless_motion3007(k+24,i-1)=cell2mat(raw3(j+k-1,3));
            end
        end
    end
end
