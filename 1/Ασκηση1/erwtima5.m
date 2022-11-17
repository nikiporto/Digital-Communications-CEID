%Data
load('cameraman.mat')
b=unique(i)

x=reshape(i,[],1)

%Freq
long=sum(ismember(x,b))
for k=1:numel(b)
  freq(k,1)=sum(ismember(x,b(k)))/long
end

prob=freq.'

%Huffmandict

[dict]=huffmandict(b,prob)

%Huffmanenco
v=i(:).'

[enco]=newhuffmanenco(v,dict)

%BSC

y=bsc(enco)

%P
count=0
for i=1:length(enco) 
  if y(i)==enco(i)
      count=count+1
  end

end
p=1-count/length(enco)

p=round(p,2)

%Capacity 
H=-p*log2(p)-(1-p)*log2(1-p)

C=1-H

%Mutual info
J = [sum(~enco & ~y),sum(~enco & y);sum(enco & ~y),sum(enco& y)]/length(enco)
MI = sum(sum(J.*log2(J./(sum(J,2)*sum(J,1)))))


%Functions
function [enco]=newhuffmanenco(inputSig,dict)
n=[]
enco = [];
for i=1:length(inputSig)
value=inputSig(i)
ind = strcmp(value, dict)
[row,col]=find(ind(:,1)==1)
n=[n row ]
end
for i=1:length(n)
enco=[enco dict(n(i),2)]

end
enco=cell2mat(enco)
end