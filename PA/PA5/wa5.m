image = imread('roman.jpg');
image_hsv = rgb2hsv(image);

red_channel = image(:, :, 1);
green_channel = image(:, :, 2);
blue_channel = image(:, :, 3);
h_channel = image_hsv(:, :, 1);
s_channel = image_hsv(:, :, 2);
v_channel = image_hsv(:, :, 3);

red_eq = histeq(red_channel, 256);
green_eq = histeq(green_channel, 256);
blue_eq = histeq(blue_channel, 256);
image_eq(:, :, 1) = red_eq;
image_eq(:, :, 2) = green_eq;
image_eq(:, :, 3) = blue_eq;
v_eq = histeq(v_channel);
image_hsv_eq(:, :, 1) = h_channel;
image_hsv_eq(:, :, 2) = s_channel;
image_hsv_eq(:, :, 3) = v_eq;
image_hsv_eq = hsv2rgb(image_hsv_eq);

[counts, bins] = imhist(red_channel);
mu = mean(red_channel(:));
num_bins = 256;
exp_hist = exprnd(mu, [1, num_bins]);
exp_hist = exp_hist * sum(counts) / sum(exp_hist);
cdf_exp = cumsum(exp_hist) / sum(exp_hist);

matched_exponential = histeq(red_channel, exp_hist);
sigma = std(double(red_channel(:)));
gaussian_hist = normrnd(mu, sigma, [1, num_bins]);
cdf_gaussian = cumsum(gaussian_hist) / sum(gaussian_hist);
matched_gaussian = histeq(red_channel, cdf_gaussian);

eff_a = 0.3;
eff_b = 0.7;
new_hist = eff_a * exp_hist + eff_b * gaussian_hist;
cdf_new = cumsum(new_hist) / sum(new_hist);
matched_new = histeq(red_channel, cdf_new);

% figure; 由于这样导出的图片严重失真，因此不选用先imshow再保存来存储图片
% subplot(5, 2, 1); imshow(red_channel); title('R Channel');
% subplot(5, 2, 2); imhist(red_channel); title('R Channel Histogram');
% subplot(5, 2, 3); imshow(red_eq); title('Histogram Equalization');
% subplot(5, 2, 4); imhist(red_eq); title('Histogram Equalization');
% subplot(5, 2, 5); imshow(matched_exponential); title('Exponential Matched');
% subplot(5, 2, 6); imhist(matched_exponential); title('Exponential Matched Histogram');
% subplot(5, 2, 7); imshow(matched_gaussian); title('Gaussian Matched');
% subplot(5, 2, 8); imhist(matched_gaussian); title('Gaussian Matched Histogram');
% subplot(5, 2, 9); imshow(image); title('Original Image');
% subplot(5, 2, 10); imshow(image_eq); title('RGB Histogram Equalization');

imwrite(red_channel,'R Channel.png');
imwrite(red_eq,'Histogram Equalization.png');
imwrite(image_eq,'RGB Histogram Equalization.png');
imwrite(matched_exponential,'Exponential Matched.png');
imwrite(matched_gaussian,'Gaussian Matched.png');
imwrite(matched_new,'New Matched.png');
imwrite(image_hsv_eq,'HSV Histogram Equalization.png');
