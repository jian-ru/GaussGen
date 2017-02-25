function kernel = generateSeparableGaussKernel(sigma, N)
% Generate a 1xN Gaussian kernel with standard deviation sigma

if (mod(N, 2) ~= 1)
    assert(false, 'Kernel size must be odd');
end

M = (N + 1) / 2;

x = 1:N;
kernel = sqrt(exp(-0.5 * (((x-M)/sigma).^2 + (M/sigma).^2)) ...
    / (2 * pi * sigma * sigma));
kernel = kernel / sum(kernel);

end