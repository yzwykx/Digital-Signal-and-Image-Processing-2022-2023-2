% 运行此代码前请先将音频文件从文件夹中移到根目录中！！！

clc;
clear;
close all;

% Problem1
[y0,Fs] = audioread('music.wav');
% [y,Fs] = audioread('好运来.mp3');
% samples = [1,4*Fs];
% clear y Fs
% [y,Fs] = audioread('好运来.mp3',samples); % 读取"好运来"音频的前四秒进行处理
% y0 = y(:,1);    % 由于原音频是双声道文件，通过这一步读取其中的第一个声道
% audiowrite("music.wav",y0,44100);
T0 = 1/Fs;
figure(1);
subplot(121);
plot(y0);
grid;
title("原音频时域图");
subplot(122);
spectrogram(y0,'yaxis');
title("原音频频谱图")

% Problem2
y1 = resample(y0,5000,Fs);
audiowrite("5kHz下采样.wav",y1,5000);
figure(2);
subplot(121);
plot(y1);
grid;
title("5kHz下采样音频时域图");
subplot(122);
spectrogram(y1,'yaxis');
title("5kHz下采样音频频谱图")
y2 = resample(y0,10000,Fs);
audiowrite("10kHz下采样.wav",y2,10000);
figure(3);
subplot(121);
plot(y2);
grid;
title("10kHz下采样音频时域图");
subplot(122);
spectrogram(y2,'yaxis');
title("10kHz下采样音频频谱图")
y3 = resample(y0,15000,Fs);
audiowrite("15kHz下采样.wav",y3,15000);
figure(4);
subplot(121);
plot(y3);
grid;
title("15kHz下采样音频时域图");
subplot(122);
spectrogram(y3,'yaxis');
title("15kHz下采样音频频谱图")

% Problem3
xq = 0:1/44100:4-1/44100;
x1 = 0:1/5000:4-1/5000;
x2 = 0:1/10000:4-1/10000;
x3 = 0:1/15000:4-1/15000;
vq1 = interp1(x1,y1,xq);
vq1(176393:176400) = 0;
vq2 = interp1(x2,y2,xq);
vq2(176397:176400) = 0;
vq3 = interp1(x3,y3,xq);
vq3(176399:176400) = 0;
audiowrite("5kHz下采样后插值.wav",vq1,44100);
figure(5);
subplot(121);
plot(vq1);
grid;
title("5kHz下采样后插值音频时域图");
subplot(122);
spectrogram(vq1,'yaxis');
title("5kHz下采样后插值音频频谱图");
audiowrite("10kHz下采样后插值.wav",vq2,44100);
figure(6);
subplot(121);
plot(vq2);
grid;
title("10kHz下采样后插值音频时域图");
subplot(122);
spectrogram(vq2,'yaxis');
title("10kHz下采样后插值音频频谱图");
audiowrite("15kHz下采样后插值.wav",vq3,44100);
figure(7);
subplot(121);
plot(vq3);
grid;
title("15kHz下采样后插值音频时域图");
subplot(122);
spectrogram(vq3,'yaxis');
title("15kHz下采样后插值音频频谱图");

% Problem4
y_100 = filt(Fs,1,100,y0);
y_200 = filt(Fs,100,200,y0);
y_500 = filt(Fs,200,500,y0);
y_1K = filt(Fs,500,1000,y0);
y_2K = filt(Fs,1000,2000,y0);
y_4K = filt(Fs,2000,4000,y0);
y_8K = filt(Fs,4000,8000,y0);
y_16K = filt(Fs,8000,20000,y0);
a = 0.20;
b = 0.90;
c = 0.90;
d = 0.90;
e = 0.80;
f = 0.80;
g = 0.10;
h = 0.10;
volume = 1;
y_1 = volume*(a*y_100+b*y_200+c*y_500+d*y_1K+e*y_2K+f*y_4K+g*y_8K+h*y_16K);
% 写入音频文件
audiowrite('music_eq.wav',y_1,Fs);

function [Y] = filt(fs,wc1,wc2,signal) 
    Wn = [wc1*2 wc2*2]/fs;                              
    [b,a] = butter(1,Wn);     
    Y = filtfilt(b,a,signal);
end
% P4参考链接：https://blog.csdn.net/qq_37147721/article/details/85453492 
% 《基于Matlab GUI的简易数字均衡器设计》