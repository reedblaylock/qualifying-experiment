function runTrainingPhaseTwoB(state)
% Instructions
text = ['Now you will learn some new words.\n' ...
        'Each word is the name of a small, fictitious country.\n' ...
		'Listen to each word, then say it out loud. You will hear each word twice.\n' ...
        'Press the Space Bar to continue.\n' ...
        ];
showInstructions(state, text);

Screen('Flip', state.win);

% For each word...
targetWords = state.targetWordsSimple;
for iWord = 1:numel(targetWords)
	% Get the recording of the word
	sndWord = getWord(state, targetWords{iWord});

	% Prepare audio
	state = prepareAudio(state, sndWord);
	
	% Get the recording duration
	wordDuration = getSoundDuration(state, sndWord);
	
	% Play each word twice
	for iRep = 1:2
		% Display the word on the screen
        DrawFormattedText(state.win, text, 50, 'center', [], [], [], [], 2);
		text = targetWords{iWord};
		Screen('Flip', state.win);

		% Play the word
		playAudio(state);

		% Wait until the word has stopped playing
		WaitSecs(wordDuration+2);
	end
	
	% Wait for space bar
	KbStrokeWait;
end

end