function [ d ] = dynamicTimeWarping( s,t )

n=size(s,1);
m=size(t,1);

DTW=zeros(n+1,m+1)+Inf;
DTW(1,1)=0;

for i=1:n
    for j=1:m
        cost=norm(s(i,:)-t(j,:));
        DTW(i+1,j+1)=cost+min( [DTW(i,j+1), DTW(i+1,j), DTW(i,j)] );
        
    end
end
d=DTW(n+1,m+1);


end

