function [ filtered ] = highpassfilter( inputVector )
%Highpass filter using diference of values
% input must be a vector with multiple collumns
length = size(inputVector,2);
filtered = zeros(1,length);
for i=2:length
    filtered(1,i)= inputVector(1,i)-inputVector(1,i-1);
end
end

