%Πηγη Α
M=10000
x= randn(M,1)

%Βαθμωτός κβαντιστής
%N=2
[xq2,centers2,D2] = Lloyd_Max(x,2,max(x),min(x))
SQNR2 = mean(x.^2)./D2
err2=mean(mean((x-xq2).^2))
%N=3
[xq3,centers3,D3] = Lloyd_Max(x,3,max(x),min(x))
SQNR3 = mean(x.^2)./D3
err3 =mean(mean((x-xq3).^2))

%N=4
[xq4,centers4,D4] = Lloyd_Max(x,4,max(x),min(x))
SQNR4 = mean(x.^2)./D4
err4 =mean(mean((x-xq4).^2))


%Διανυσματικός κβαντιστής

%Ν=2 k=4
%[xqv2,centers,Dv2]=vector_quant(x,4) 
%SQNRv2 = mean(x.^2)./Dv2
%errv2 = =mean(mean((x-xqv2).^2))

%Ν=3 k=6
%[xqv4,centers,Dv3]=vector_quant(x,6) 
%SQNRv3 = mean(x.^2)./Dv3
%errv3 = mean(mean((x-xqv3).^2))
%Ν=4 k=8
%[xqv4,centers,Dv4]=vector_quant(x, 8) 
%SQNRv4 = mean(x.^2)./Dv4
%errv4 =mean(mean((x-xqv4).^2))

%Συγκριση mean distrortion
%N=2
Md2=mean(D2)-mean(Dv2)
%N=3
Md3=mean(D3)-mean(Dv3)
%N=4
Md4=mean(D4)-mean(Dv4)


function [xq,centers,D] = Lloyd_Max(x,N,max_value,min_value)


qlevels=2.^N                
centers=zeros(qlevels,1)   
T = zeros(qlevels+1,1)     
step = (max_value+abs(min_value))/(qlevels) 
 

centers = min_value + step/2 : step :max_value-(step/2)
 
 
 
Dp=0                  
diff=1                   
count=1                     
epsilon = 1e-7           
 

while(diff>e)
    
   
    
    T(1) = -inf
    for j=2:qlevels
        T(j)= 0.5*( centers(j-1)+centers(j) )
    end
    T(qlevels+1) = inf
    
    
    
    for i=1:length(x)
        for k=1:qlevels
           if ((x(i)<=T(k+1)) && (x(i)>T(k)))
                   xq(i)=centers(k)
           end
        end
    end
    
    
    d = mean((x-xq').^2)
    D(count) = d
    
    
    diff = abs(D(count)-Dp)
    Dp = D(count)
 
    
  
   for k=1:qlevels
        centers(k) = mean ( x ( x>T(k) & x<=T(k+1) ))
    end
        
    
    count = count + 1
    
end
 
end

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
