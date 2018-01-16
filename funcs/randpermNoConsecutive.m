function outputPermutation = randpermNoConsecutive(nValues)
% Consecutive values cannot be within the same pair grouping
% (e.g., {1 2}, {3 4})

nConsecutive = 1;

while nConsecutive > 0
	outputPermutation = randperm(nValues);

	nConsecutive = 0;
	for i = 1:nValues-1
		% True for 1 + 2, 3 + 4, ... but not for 2 + 3, 4 + 5, ...
		if mod(outputPermutation(i) + outputPermutation(i+1), 4) == 3
			nConsecutive = nConsecutive + 1;
		end
	end
end

end