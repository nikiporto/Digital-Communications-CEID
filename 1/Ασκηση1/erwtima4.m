az='a':'z'
[d]=regexp(az, '\S', 'match')

x={}
count=1
for i=1:length(d)
 for j=1:length(d)
  x(count)=strcat(d(i),d(j))
  count=count+1
  end
end


s=importdata('cvxopt.txt')
str= cell2mat(s)
str=str(find(~isspace(str)))
a=cellstr(reshape(str,2,[])')

long=sum(ismember(a,x))
for k=1:numel(x)
  freq(k,1)=sum(ismember(a,x(k)))/long
end

[dict]=huffmandict(x,freq)

[enco]=newhuffmanenco(a,dict)


p=freq.'

%Entropy
pnz=nonzeros(p)
ent = -sum(pnz.*log2(pnz))

%Average length
v=[]
for i=1:length(dict)
v=[v length(cell2mat(dict(i,2)))]
end

averagelength=sum(p.*v)

%Efficiency of code
ef=100*(ent/averagelength)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
