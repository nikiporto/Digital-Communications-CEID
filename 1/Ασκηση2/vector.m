

function [xq,centers,D]=vector_quant(x,k)

[idx,C] = kmeans(x,k)
centers=C

xq=[]
for i=1:length(idx)
    
  xq(i)=C(idx(i))
end
D = mean((x-xq)).^2
MEAND=mean(D)
end

