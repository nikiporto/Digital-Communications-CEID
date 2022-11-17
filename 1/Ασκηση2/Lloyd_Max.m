

function [xq,centers,D] = Lloyd_Max(x,N,max_value,min_value)


qlevels=2.^N                
centers=zeros(qlevels,1)   
T = zeros(qlevels+1,1)     
step = (max_value+abs(min_value))/(qlevels) 
 

centers = min_value + step/2 : step :max_value-(step/2)
 
 
 
Dp=0                  
diff=1                   
count=1                     
epsilon = 10.^-6      
 

while(diff>epsilon)
    
   
    
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