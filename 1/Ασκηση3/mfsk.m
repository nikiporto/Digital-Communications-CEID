%Πομπος
%Δυαδικη ακολουθια
M=8
Lb=300000
bs = randsrc(Lb, 1, [0,1])


%Mapper
temp = mod(length(bs), log2(M))
n = bs(1 : (length(bs) - temp), :)
rn = reshape(n, log2(M), (length(bs) - temp) / log2(M))

symbols = bin2dec(num2str(rn'))



%Pulse
Tsymbol=4*10.^(-6)
Es = 1
g = sqrt(2 * Es / Tsymbol)


%FSK signals

fc=2.5*10.^6
Tsample=0.1*10.^(-6)
Tc=1/fc

sm = zeros(M, Tc/(Tsample))

t=Tc/(Tc/Tsample):Tc/(Tc/Tsample):Tc
for i = 1: M
  sm(i,:) =g*cos(2*pi*t*(fc+(i-1)/Tsymbol))
end


%Symbols to be sent
Syms=zeros(size(symbols,2),(Tc/Tsample)*Tsymbol/Tc)

Syms=repmat(sm(symbols+1,:),1,Tsymbol/Tc)

%AWGN

SNR=40
Eb = Es / log2(M)
N0 = Eb / (10^(SNR/10))
mean = 0
sigma = sqrt(N0 / 2)
noise = mean + sigma * randn(Lb/log2(M),1*40)


%R
rs = Syms + noise


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Δεκτης
%Fsk signals δεκτης

p=rs
h=zeros(Lb/log2(M),4)
rm=repmat(sm,1,Tsymbol/Tc)
h=mtimes(p,rm.')



%Φωρατης

[megisto,I] = max(h,[],2)

%Demapper

fn=I-1
np= dec2bin(fn,log2(M))
[lines, columns] = size(np)
ni = reshape(np', lines*columns, 1)
output= double(ni) - 48
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BER = sum(bs ~= output)/length(output)

SER=sum(symbols ~= fn)/length(fn)