function applyTextStyle(win, styles)
	if (~iscell(styles))
		styles = {styles};
	end
	
	for iStyle = 1:numel(styles)
		styleValue = 0;
		
		strExists = sum(strfind(styles{iStyle}, 'bold'));
		if (strExists)
			styleValue = styleValue + 1;
		end
		
		strExists = sum(strfind(styles{iStyle}, 'italic'));
		if (strExists)
			styleValue = styleValue + 2;
		end
		
		strExists = sum(strfind(styles{iStyle}, 'underline'));
		if (strExists)
			styleValue = styleValue + 4;
		end
	end

	Screen('TextStyle', win, styleValue);
end