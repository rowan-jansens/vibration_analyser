% t = linspace(0,pi,50)';
% X = ones(50,3);
% X(:,2) = cos(t);
% X(:,3) = sin(t);
% 
% y = 2*cos(1.5*t-2)+randn(size(t));
% 
% 
% y = y(:);
% beta = X\y;
% yhat = beta(1)+beta(2)*cos(t)+beta(3)*sin(t);
% plot(t,y,'b');
% hold on
% plot(t,yhat,'r','linewidth',2



%t = linspace(0,pi,50)';

% Fs = 1000;            % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
% L = 1500;             % Length of signal
% t = (0:L-1)*T;        % Time vector
% 
% S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% X = S + 2*randn(size(t));
% Y = fft(X);P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% f = Fs*(0:(L/2))/L;
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')


sample_rate = 0.01;
length = 1000;

t = linspace(0,length,length/sample_rate);


y1 = 0.9 * sin(t + 0.09);
y2 = 1.2 * sin(t + 1.39);

figure(1)
clf

hold on
plot(t, y1)
plot(t, y2)

hold off

[c, lag] = xcorr(y1, y2);
[val, id] = max(c);
lag = lag(id);
lag = lag * sample_rate