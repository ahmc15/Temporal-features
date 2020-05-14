function histo= Dohisto(x)
% creates a array of the number of elements on each unitary interval
    x = x(:);
    sortedx =sort(x);
    bins = floor(max(x)-min(x));
    histo = zeros([bins,1]);
    for i = 1:bins
        histo(i) = length(sortedx(sortedx >=(i-1) & sortedx <i));
    end
    
end
