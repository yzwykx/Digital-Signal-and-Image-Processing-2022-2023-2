% 随机生成长度为2^4的序列
x = rand(1,2^4);
% 随机生成长度为2^8的序列
% x = rand(1,2^8);
% 随机生成长度为2^12的序列
% x = rand(1,2^12);
% 随机生成长度为2^16的序列
% x = rand(1,2^16);
% 随机生成长度为2^20的序列
% x = rand(1,2^20);
% 随机生成长度为2^24的序列
% x = rand(1,2^24);
% 随机生成长度为2^28的序列
% x = rand(1,2^28);
% 随机生成长度为2^32的序列
x = rand(1,2^32);

N = length(x); % 序列长度
X = zeros(1,N); % DFT序列

profile on;

% 使用for循环计算DFT
% for k = 0:N-1
%     for n = 0:N-1
%         X(k+1) = X(k+1) + x(n+1) * exp(-1j * 2 * pi * k * n / N);
%     end
% end

% 使用矩阵运算计算DFT
% W = exp(-1j*2*pi*(0:N-1)'*(0:N-1)/N);
% X = W * x';

% 使用fft函数计算DFT
X = fft(x);

% 使用fft函数计算DFT，并使用GPU加速
% X = fft(gpuArray(x));

profile off;
%disp(X); % 测试，检验输出结果
profile report;