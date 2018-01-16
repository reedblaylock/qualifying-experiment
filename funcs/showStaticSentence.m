function [VBLTimestamp, StimulusOnsetTime, FlipTimestamp] = showStaticSentence(state, targetWord, nmat, sentenceFrame, wordTimes)

nx = 50;
ny = 'center';

% Start with default styles
win = state.win;
applyDefaultTextStyles(win);

% Draw each word separately
for iWord = 1:size(wordTimes, 1)
	% If the word has maximum amplitude, underline it
	if ~isempty(nmat)
		noteBeingDrawn = wordTimes(iWord, 1);
		if(noteBeingDrawn > 0 && nmat(noteBeingDrawn, 5) == state.maxAmplitude)
			applyTextStyle(win, 'underline')
		end
	end

	if iWord == 6
		% Concatenate the target word to any following punctuation
		word = [targetWord sentenceFrame{iWord}];
	else
		word = sentenceFrame{iWord};
	end
	
	wordHasHyphen = ~isempty(regexp(word, '-', 'once'));
	if wordHasHyphen
		word = word(1:end-1);
	end

	[nx, ny, ~] = DrawFormattedText(win, word, nx, ny);

	applyDefaultTextStyles(win);

	if ~wordHasHyphen
		[nx, ny, ~] = DrawFormattedText(win, ' ', nx, ny);
	end
end

% Flip to the screen
[VBLTimestamp, StimulusOnsetTime, FlipTimestamp] = Screen('Flip', win);

end