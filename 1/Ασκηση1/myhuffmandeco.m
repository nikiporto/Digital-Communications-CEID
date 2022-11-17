inputSig = {'a2','44','a3','55','a1'}
dict = {'a1',0; 'a2',10; 'a3',110; '44',1110; '55',1111}
enco = huffmanenco(inputSig,dict);
[sig]=newhuffmandeco(enco,dict)

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
