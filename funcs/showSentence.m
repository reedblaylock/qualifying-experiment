function showSentence(state, targetWord, iNote, nmat, sentenceFrame, sentenceFrameWordTimes)

nx = 50;
ny = 'center';

% Start with default styles
win = state.win;
applyDefaultTextStyles(win);

% Draw each word separately
for iWord = 1:size(sentenceFrameWordTimes, 1)
	% If the word has maximum amplitude, underline it
	noteBeingDrawn = sentenceFrameWordTimes(iWord, 1);
	if(noteBeingDrawn > 0 && nmat(noteBeingDrawn, 5) == state.maxAmplitude)
		applyTextStyle(win, 'underline')
	end

	% If the word is currently being played, make it red
	if(iWord == iNote)
		red = [1 0 0];
		applyTextColor(win, red);
	end

	if iWord == 6
		% Concatenate the training word to any following
		% punctuation
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
Screen('Flip', win);
WaitSecs(sentenceFrameWordTimes(iNote, 3)-state.avcorrection);

end