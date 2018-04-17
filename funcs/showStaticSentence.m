function [] = showStaticSentence(state, targetWord, sentenceFrame)

nx = 50;
ny = 'center';

% Start with default styles
win = state.win;
applyDefaultTextStyles(win);

% Draw each word separately
targetWordSyllablesUsed = 0;
for iWord = 1:size(sentenceFrame, 1)
	% If the word has maximum amplitude, underline it
	if mod(iWord, 3) == 1
		applyTextStyle(win, 'underline')
	end

	if isempty(regexp(sentenceFrame{iWord}, '[a-z]', 'once'))
		% Concatenate the training word to any following
		% punctuation
		word = [targetWord{targetWordSyllablesUsed+1} sentenceFrame{iWord}];
        targetWordSyllablesUsed = targetWordSyllablesUsed + 1;
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

end