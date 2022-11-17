%πιθανότητες των συμβόλων της πηγής Α
s=importdata('cvxopt.txt')
str = cell2mat(s)
str = replace(str, ' ', '#')
a = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' '#' ]
long=sum(ismember(str,a));
for k=1:numel(a)
  freq(k,1)=sum(ismember(str,a(k)))/long
end


%Huffmandict
a = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' '#' }
p=freq.'
[dict] = huffmandict(a,p)

%Hufmanenco
[inputSig]=regexp(str, '\S', 'match')
[enco]=newhuffmanenco(inputSig,dict)


%Hufmandeco
[sig]=newhuffmandeco(enco,dict)

%Entropy
ent = -sum(p.*log2(p))

%Average length
v=[]
for i=1:length(dict)
v=[v length(cell2mat(dict(i,2)))]
end

averagelength=sum(p.*v)

%Efficiency of code
ef=100*(ent/averagelength)


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


function [sig]=newhuffmandeco(enco,dict)
enco=num2cell(enco)
enco=string(enco)
dict=string(dict)
n=[]
sig = [];
for i=1:length(enco)
value=enco(i)
ind=strcmp(value,dict)
[row,col]=find(ind==1)
n=[n row ]
end
for i=1:length(n)

    sig=[sig dict(n(i),1)]

end
end