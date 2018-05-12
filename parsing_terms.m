clear all;
clc;
Term={'acty', 'anst', 'antb', 'bacs', 'bdsu', 'bdsy', 'bhvr', 'biof', 'blor', 'bpoc', 'bsoj', 'clna', 'clnd', 'diap', 'dsyn', 'dora', 'edac', 'evnt', 'fndg', 'hlca', 'inbe', 'lbtr', 'medd', 'menp', 'mobd', 'npop',  'orch', 'orgf', 'patf', 'phsf', 'phsu', 'socb', 'sosy', 'topp'};
Num_eachTerm=zeros(1,34);
Sequence_Terms_all=[ ];
[number3,txt3,raw3]=xlsread('3003comm.xls');
[number4,txt4,raw4]=xlsread('3004comm.xls');
[number7,txt7,raw7]=xlsread('3007comm.xls');
table3003=[];
table3004=[];
table3007=[];
for k=1:length(raw3)
    temp_file=fopen('temp.txt','w');
    fprintf(temp_file,'%s',cell2mat(raw3(k+1,8)));
    dos('metamaplite.bat');
    temp=fopen('temp.mmi');
    [Visit,count]=fscanf(temp,'%s');
    for i=1:length(Term)
        first=strfind(Visit,cell2mat(Term(i)));
        Num_eachTerm(i)=length(first);
        if ~isempty(first)
            for j=1:Num_eachTerm(i)
                %     La=La+1;
                % 'T',num2str(La),':'
                Cor_Terms=strcat([Visit(first(j)),Visit(first(j)+1),Visit(first(j)+2),Visit(first(j)+3)]);
                while ~feof(temp)
                    one_line=fgetl(temp);
                    if ~isempty(strfind(one_line,Cor_Terms))
                        finding=find(one_line=='|');
                        terms=[one_line(1,(finding(2)+1):(finding(3)-1))];
                        break;
                    end
                    num_line=num_line+1;
                end
                Sequence_Terms=strcat([' ',Cor_Terms,':',terms,';  ']);
                Sequence_Terms_all=[Sequence_Terms_all Sequence_Terms];
            end
        end
    end
    if ~isempty(Sequence_Terms_all)
        table3003=[table3003;all.alldata(k,:) Sequence_Terms_all];
    else
        table3003=[table3003;all.alldata(k,:) empty];
    end
    Sequence_Terms=[];
    Sequence_Terms_all=[];
    % La=0;
    Num_eachTerm(:,:)=0;
end
