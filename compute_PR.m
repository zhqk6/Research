function [P,R]=compute_PR(vect1,vect2)
%vect1 is the certain day
%vect2 is the compared day
% 
% vect1=cell2mat(vect1);
% vect2=cell2mat(vect2);
TP=0;
TP_temp=0;
for i=1:length(vect1)
    if vect1(i)~=0 && vect2(i)~=0
        TP_temp=min(vect1(i),vect2(i));
        TP=TP+TP_temp;
    end
end
P=TP/sum(vect1);
R=TP/sum(vect2);
