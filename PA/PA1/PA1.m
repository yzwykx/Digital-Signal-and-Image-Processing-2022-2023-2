A = imread("baboon.bmp");
B = [ 0.04 0.04 0.04 0.04 0.04 ;
      0.04 0.04 0.04 0.04 0.04 ;
      0.04 0.04 0.04 0.04 0.04 ;
      0.04 0.04 0.04 0.04 0.04 ;
      0.04 0.04 0.04 0.04 0.04 ]; % 卷积核（点扩散函数）
rect = [3,3,511,511]; % imcrop截取函数的参数，用以将卷积得到的516*516图像截取成512*512图像

C = conv2(A,B);
C1 = uint8(C);
Cout = imcrop(C1, rect);
imwrite(Cout,'blurred.bmp');

% 加入高斯噪声
D1 = awgn(C,30,"measured");
D11 = uint8(D1);
D1out = imcrop(D11, rect);
imwrite(D1out,'blurred and noised in 30 dB.bmp'); % 加入30dB高斯噪声

D2 = awgn(C,20,"measured");
D21 = uint8(D2);
D2out = imcrop(D21, rect);
imwrite(D2out,'blurred and noised in 20 dB.bmp'); % 加入20dB高斯噪声

D3 = awgn(C,10,"measured");
D31 = uint8(D3);
D3out = imcrop(D31, rect);
imwrite(D3out,'blurred and noised in 10 dB.bmp'); % 加入10dB高斯噪声

%直接逆滤波
W0 = deconvwnr(C,B,0);
W01 = uint8(W0);
W0out = imcrop(W01, rect);
imwrite(W0out,'directly recoverd.bmp'); % 对仅卷积点扩散函数的图像直接逆滤波复原

W1 = deconvwnr(D1,B,0);
W11 = uint8(W1);
W1out = imcrop(W11, rect);
imwrite(W1out,'directly 30dB recoverd.bmp'); % 对添加30dB高斯噪声的图像直接逆滤波复原

W2 = deconvwnr(D2,B,0);
W21 = uint8(W2);
W2out = imcrop(W21, rect);
imwrite(W2out,'directly 20dB recoverd.bmp'); % 对添加20dB高斯噪声的图像直接逆滤波复原

W3 = deconvwnr(D3,B,0);
W31 = uint8(W3);
W3out = imcrop(W31, rect);
imwrite(W3out,'directly 10dB recoverd.bmp'); % 对添加10dB高斯噪声的图像直接逆滤波复原

%Wiener滤波
X1 = deconvwnr(D1,B,1/30);
X11 = uint8(X1);
X1out = imcrop(X11, rect);
imwrite(X1out,'Wiener 30dB recoverd.bmp'); % 对添加30dB高斯噪声的图像Wiener滤波复原

X2 = deconvwnr(D2,B,1/20);
X21 = uint8(X2);
X2out = imcrop(X21, rect);
imwrite(X2out,'Wiener 20dB recoverd.bmp'); % 对添加20dB高斯噪声的图像Wiener滤波复原

X3 = deconvwnr(D3,B,1/10);
X31 = uint8(X3);
X3out = imcrop(X31, rect);
imwrite(X3out,'Wiener 10dB recoverd.bmp'); % 对添加10dB高斯噪声的图像Wiener滤波复原


