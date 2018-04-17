function newArray = randpermNoConsecutiveAfter(oldArray, nValues)
% The beginning of the new array cannot be the same as the end of the old array
% The beginning of the new array cannot be within the same pair grouping (e.g.,
% {1 2}, {3 4}) as the end of the old array

if isempty(oldArray)
    if nValues == 2
        newArray = randperm(nValues);
    else
        newArray = randpermNoConsecutive(nValues);
    end
else
	works = false;

	while ~works
        if nValues == 2
            newArray = randperm(nValues);
        else
            newArray = randpermNoConsecutive(nValues);
        end

        if nValues > 2
            % If the values are far enough apart, you're good
            if (oldArray(end) == newArray(1)) || (mod(oldArray(end) + newArray(1), 4) == 3)
                works = false;
            else
                works = true;
            end
        else
            works = true;
        end
	end
end

end