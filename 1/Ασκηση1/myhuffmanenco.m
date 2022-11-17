inputSig = {'a2','44','a3','55','a1'}
dict = {'a1',0; 'a2',10; 'a3',110; '44',1110; '55',1111}

[enco]=newhuffmanenco(inputSig,dict)


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


 

