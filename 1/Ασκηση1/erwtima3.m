%Data
a = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' '#'}
p = [  0.0698 0.0128 0.0238 0.0364 0.1086 0.0190 0.0172 0.0521 0.0595 0.0013 0.0066 0.0344 0.0206 0.0577 0.0642  0.0165 0.0008 0.0512 0.0541 0.0774 0.0236 0.0084 0.0202 0.0010 0.0169 0.0006 0.1453]
s=importdata('cvxopt.txt')
str = cell2mat(s)
str = replace(str, ' ', '#')

%Huffmandict
[dict] = huffmandict(a,p)

%Huffmanenco
[inputSig]=regexp(str, '\S', 'match')
[enco]=newhuffmanenco(inputSig,dict)

%Entropy
ent = -sum(p.*log2(p))

%Average length
v=[]
for i=1:length(dict)
v=[v length(cell2mat(dict(i,2)))]
end

averagelength=sum(p.*v)


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
