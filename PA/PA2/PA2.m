t=-50:0.01:50; %1
figure(1);
x = heaviside(t)-heaviside(t-10);
x(5001)=1;
x(6001)=1;
plot(t,x);
ylabel('x(t)');
xlabel('t(s)');
axis([-10,20,-1,2]);
grid on;

figure(2);
Ts1=1;
Fs1=1;
t1=-20:1:20;
Ns1=100;
n1=3001:Ns1:7001;
s1=x(n1);
stem(t1,s1,'filled');
axis([-20,20,-1,2]);

figure(4); %2
x2 = heaviside(t-0.5)-heaviside(t-10.5);
x2(5051)=1;
x2(6051)=1;
s2=x2(n1);
stem(t1,s2,'filled');
axis([-20,20,-1,2]);

figure(5); %3
[n,Wn] = buttord(0.063,0.09,3,45)
[b,a] = butter(n,Wn,'low');
x3 = filter(b,a,x2);
s3=x3(n1);
stem(t1,s3,'filled');
axis([-20,20,-1,2]);

figure(3);
y1=fft(s1);
y11=fftshift(y1);
f1 = Fs1*(-20:20)/40;
plot(f1,abs(y11));
hold on;
y2=fft(s2);
y21=fftshift(y2);
plot(f1,abs(y21));
hold on;
y3=fft(s3);
y31=fftshift(y3);
plot(f1,abs(y31));
legend({'原始','平移','低通滤波'});
