function runTrainingPhaseFour(state, blockName)
% Instructions
nNotes = blockName(end);
text = ['Now, try it with just the metronome, and no other help.\n' ...
		'Remember, the underlined words mark the beginning of groups of ' nNotes ' notes.\n' ...
		'Press the any key to start singing.' ...
		];
showInstructions(state, text);

% Get music
[snd, nmatMetronome] = getMetronome(state, blockName);
[~, nmatMelody] = getMelody(state, blockName);
metronomeDuration = getMetronomeDuration(nmatMetronome);

% Prepare audio
% PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);
state = prepareAudio(state, snd);

% Calculate the onset landmark, in milliseconds, of each note and text change
wordTimes = getWordTimes(state, blockName, nmatMelody);
frameName = ['sentenceFrame', blockName(1)];
sentenceFrame = state.(frameName);

% Randomize words
nTrainingWords = numel(state.trainingWords);
trainingOrder = randperm(nTrainingWords); % randomly ordered integers from 1 through nTrainingWords

for iTrainingWord = 1:nTrainingWords
	targetWord = state.trainingWords{trainingOrder(iTrainingWord)};
	
% Practice singing
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);

	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration);
% 	PsychPortAudio('Stop', state.pahandle);

	KbStrokeWait;
end

end