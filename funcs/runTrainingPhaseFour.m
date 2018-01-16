function runTrainingPhaseFour(state, blockName)

text = ['Now, try it with just the metronome, and no other help.\n' ...
		'Press the any key to start singing.' ...
		];
showInstructions(state, text);

% nmatMetronome = generateMidiGrid(state, state.blocks.(blockName).metronome);
nmatMetronome = getMetronome(state, state.blocks.(blockName).metronome);
metronomeDuration = getMetronomeDuration(nmatMetronome);

prepareAudio(state, nmatMetronome);

% Calculate the onset landmark, in milliseconds, of each note and text change
nmatMelody = generateMidiGrid(state, state.blocks.(blockName).midi);
wordTimes = getWordTimes(state, blockName, nmatMelody);

% bpmeasure = state.blocks.(blockName).beatsPerMeasure;
% frameName = ['sentenceFrame', num2str(bpmeasure)];
frameName = ['sentenceFrame', blockName(1)];
sentenceFrame = state.(frameName);

nTrainingWords = numel(state.trainingWords);
trainingOrder = randperm(nTrainingWords); % randomly ordered integers from 1 through nTrainingWords

for iTrainingWord = 1:nTrainingWords
	targetWord = state.trainingWords{trainingOrder(iTrainingWord)};
	
% Practice singing
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);
% 	[VBLTimestamp, StimulusOnsetTime, FlipTimestamp] = showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);
% 	saveTimestamp(state, [VBLTimestamp, StimulusOnsetTime, FlipTimestamp], targetWord);

	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration);

	KbStrokeWait;
end

end