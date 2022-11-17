%Πηγη Β
M=1000
x = randn(M,1)
b = 1
a = [1 1/2 1/3 1/4 1/5 1/6 ]
y = filter(b,a,x)

%Βαθμωτός κβαντιστής
%N=2
[xq2,centers2,D2] = Lloyd_Max(y,2,max(y),min(y))
SQNR2 = mean(y.^2)./D2
err2 =mean(mean((x-xq2).^2))

%N=3
[xq3,centers3,D3] = Lloyd_Max(y,3,max(y),min(y))
SQNR3 = mean(y.^2)./D3
err3 =mean(mean((x-xq3).^2))

%N=4
[xq4,centers4,D4] = Lloyd_Max(y,4,max(y),min(y))
SQNR4 = mean(y.^2)./D4
err4 = mean(mean((x-xq4).^2))

%Ν=2 k=4
%[xqv2,centers,Dv2]=vector_quant(y,4) 
%SQNRv2 = mean(y.^2)./Dv2
%errv2 = immse(y-xqv2)

%Ν=3 k=6
%[xqv4,centers,Dv3]=vector_quant(y,6) 
%SQNRv3 = mean(y.^2)./Dv3
%errv3 = immse(y-xqv3)

%Ν=4 k=8
%[xqv4,centers,Dv4]=vector_quant(y, 8) 
%SQNRv4 = mean(y.^2)./Dv4
%errv4 = immse(y-xqv4)




function [xq,centers,D]=vector_quant(x,k)

[idx,C] = kmeans(x,k)
centers=C

xq=[]
for i=1:length(idx)
    
  xq(i)=C(idx(i))
end
D = (x-xq).^2
MEAND=mean(D)
end
