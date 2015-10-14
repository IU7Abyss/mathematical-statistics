close all;
clc;

x = csvread('data.csv');

xmin = min(x);
xmax = max(x);
xrange = range(xmin,20);
xmean = mean(x);
xvar = var(x);
xsigma = sqrt(xvar);

fprintf('min = %.2f\nmax = %.2f\nrange = %.2f\n', xmin, xmax, xrange);
fprintf('mean = %f\nvariance = %f\n', xmean, xvar);

xn = length(x);
jn = floor(log2(xn)) + 2;
[y1, x1] = hist(x, jn); 
y1 = y1 / (sum(y1) * (x1(2) - x1(1)));
xnorm = (xmean - 4 * xsigma):(xsigma / 100):(xmean + 4 * xsigma);
ynormp = normpdf(xnorm, xmean, xsigma);
ynormc = normcdf(xnorm, xmean, xsigma);

figure
bar(x1, y1, 1);
hold on;
plot(xnorm, ynormp, 'r');
hold off;

figure
ecdf(x);
axis tight;
hold on;
plot(xnorm, ynormc, 'r');
hold off;
