%PAM
Es=1
T=1
roll_off_factor=0.3
up=4
%plot(s_m,[0,0,0,0],'o') αστερισμοί
M=4
m=1:M
s_m4=(2*m-1-M)*Es

M=8
m=1:M
s_m8=(2*m-1-M)*Es

Lb=1000
Signal=randsrc(Lb, 1, [0,1])
%Mapper4
M=4
temp = mod(Lb, log2(M))
n = Signal(1 : (Lb - temp), :)
rn = reshape(n, log2(M), (Lb - temp) / log2(M))

Signal_dec4 = bin2dec(num2str(rn'))
Signal4=zeros(length(Signal_dec4),1)

for i=1:length(Signal_dec4)
    Signal4(i,1)=s_m4(Signal_dec4(i)+1)
end


%Mapper8
M=8
temp = mod(Lb, log2(M))
n = Signal(1 : (Lb - temp), :)
rn = reshape(n, log2(M), (Lb - temp) / log2(M))

Signal_dec8 = bin2dec(num2str(rn'))
Signal8=zeros(length(Signal_dec8),1)

for i=1:length(Signal_dec8)
    Signal8(i,1)=s_m8(Signal_dec8(i)+1)
end

%----------------



SER41=[]
SER42=[]
SER43=[]


SER81=[]
SER82=[]
SER83=[]
SNR=[0:2:30]

for i=1:length(SNR)
        [ output ] = MPAM( Signal4, 4, 0.3, T, '1', SNR(i), s_m4 )
        SER41(i,1) = sum(xor(output,Signal4)) / length(Signal4)
end


for i=1:length(SNR)
        [ output ] = MPAM( Signal4, 4, 0.3, T, '2', SNR(i), s_m4 )
        SER42(i,1) = sum(xor(output,Signal4)) / length(Signal4)
end

for i=1:length(SNR)
        [ output ] = MPAM( Signal4, 4, 0.3, T, '3', SNR(i), s_m4 )
        SER43(i,1) = sum(xor(output,Signal4)) / length(Signal4)
end

for i=1:length(SNR)
        [ output ] = MPAM( Signal8, 4, 0.3, T, '1', SNR(i), s_m8 )
        SER81(i,1) = sum(xor(output,Signal8)) / length(Signal8)
end


for i=1:length(SNR)
        [ output ] = MPAM( Signal8, 4, 0.3, T, '2', SNR(i), s_m8 )
        SER82(i,1) = sum(xor(output,Signal8)) / length(Signal8)
end

for i=1:length(SNR)
        [ output ] = MPAM( Signal8, 4, 0.3, T, '3', SNR(i), s_m8 )
        SER83(i,1) = sum(xor(output,Signal8)) / length(Signal8)
end


%----------------

function [ output ] = MPAM( Signal, up, roll_off_factor, T, channel_type, SNR, symbols )

%Upsampling
Signal_up = upsample(Signal,up)
Signal_up = Signal_up(1:(length(Signal_up)-(up-1)))

%Transmission filter
t_filter = rcosfir(roll_off_factor  , [-T/2 , T/2] , up , 1 , 'sqrt');
t_filter = t_filter./norm(t_filter);

%Output of transmitter
in = conv(t_filter, Signal_up);


%Channel output
if  (channel_type=='1')
    channelled_output=in
elseif (channel_type=='2')

    h= [ 0.04 -0.05 0.07 -0.21 -0.5 0.72 0.36 0 0.21 0.03 0.07]
    h_up = upsample(h,up)
    h_up = h_up(1:(length(h_up)-(up-1)))

    channelled_output = conv(h_up,in)
elseif (channel_type=='3')

    h = [0.407 0.815 0.407]
    h_up = upsample(h,up);
    h_up = h_up(1:(length(h_up)-(up-1)))

    channelled_output = conv(h_up,in)
end 
%White noise addition
Ps = sum(abs(channelled_output).^2) / length(channelled_output)
Pn = Ps/(10^(SNR/10))


sigma = sqrt(Pn)
noise = sigma *(randn(length(channelled_output),1))

channel_output=channelled_output+noise



%Reciever filter
r_filter = t_filter

%Filter output
received = conv(r_filter,channel_output)

%FIR DELAY
N_filter = length(r_filter)
N_signal = length(Signal_up)

if  (channel_type=='1')
    delay = 2*floor(N_filter/2)
else
    N_channel=length(h_up)
    delay = 2*floor(N_filter/2) + floor(N_channel/2)
end


s_delayed = received(delay+1:(end-delay))
Signal_down = downsample(s_delayed,up)


N_signal_down = length(Signal_down)
symbols_length = length(symbols)
%Output matrix initialization
output = zeros(N_signal_down,1)
%Distance matrix initialization
D = zeros(symbols_length,1)
% Calculating symbol distance and picking the symbol with min dist.
for i=1:N_signal_down
    % Symbol distance
    for j=1:symbols_length
        D(j) = (Signal_down(i) - symbols(j))^2
    end
    % Sorting D
    [D,I] = sort(D,'ascend')
    % Picking the symbol
    output(i) = symbols(I(1))
end
end




