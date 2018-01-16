function newArray = randpermNoConsecutiveAfter(oldArray, nValues)
% The beginning of the new array cannot be the same as the end of the old array
% The beginning of the new array cannot be within the same pair grouping (e.g.,
% {1 2}, {3 4}) as the end of the old array

if isempty(oldArray)
	newArray = randpermNoConsecutive(nValues);
else
	works = false;

	while ~works
		newArray = randpermNoConsecutive(nValues);

		% If the values are far enough apart, you're good
		if (oldArray(end) == newArray(1)) || (mod(oldArray(end) + newArray(1), 4) == 3)
			works = false;
		else
			works = true;
		end
	end
end

end