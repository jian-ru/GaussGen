function kernel = getAppropriateSeparableGauss(N)
% Search for sigma to cover the whole kernel size with sensible values
% (might not be ideal for all cases quality-wise but is good enough for performance testing)

if (mod(N, 2) ~= 1)
    assert(false, 'Kernel size must be odd');
end

epsilon = 0.02 / N;
searchStep = 1;
sigma = 1;

while true
    kernelAttempt = generateSeparableGaussKernel(sigma, N);
%     kernelAttempt = fspecial('gaussian', [1, N], sigma);
    
    if (kernelAttempt(1) > epsilon)
        if (searchStep > 0.02)
            sigma = sigma - searchStep;
            searchStep = searchStep * 0.1;
            sigma = sigma + searchStep;
            continue;
        end
        
        kernel = kernelAttempt;
        break;
    end
    
    sigma = sigma + searchStep;
    
    if (sigma > 1000)
        assert(false);
    end
end

end

