function [weights, offsets] = generateGaussWeightsAndOffsets(N)
% Generate the weights and offsets of an NxN Gaussian kernel such that when combined with linearly filtered texel read,
% produce the correct result as if the image was filtered by the NxN Gaussian kernel.
%
% Reference: https://software.intel.com/en-us/blogs/2014/07/15/an-investigation-of-fast-real-time-gpu-based-image-blur-algorithms

assert(mod(N, 2) == 1, 'Kernel size must be odd');
assert(mod(floor(N/2)+1, 2) == 0, 'Half kernel size (including middle element) must be even');

kernel = getAppropriateSeparableGauss(N);
oneSideInputs = kernel(ceil(N/2):end);
oneSideInputs(1) = oneSideInputs(1) * 0.5;

numSamples = ceil(N/2) / 2;
weights = oneSideInputs(1:2:end) + oneSideInputs(2:2:end);
offsets = (0:(numSamples-1))*2 + oneSideInputs(2:2:end) ./ weights;

fid = fopen('weightsAndOffsets.json', 'w');
fprintf(fid, '{\n');
fprintf(fid, '\t"Kernel size": %d\n', N);
fprintf(fid, '\t%s: [', '"Weights"');
fprintf(fid, '%.6f, ', weights(1:end-1));
fprintf(fid, '%.6f]', weights(end));
fprintf(fid, '\n\t%s: [', '"Offsets"');
fprintf(fid, '%.6f, ', offsets(1:end-1));
fprintf(fid, '%.6f]', offsets(end));
fprintf(fid, '\n}');
fclose(fid);

end

