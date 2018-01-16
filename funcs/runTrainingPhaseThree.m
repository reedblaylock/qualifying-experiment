function runTrainingPhaseThree(state, blockName)
% Hear melody with words

text = ['In the next examples, the melody will be matched to words.\n' ...
		'Learn how to match every word to a note by listening and watching.\n' ...
		'When the melody has finished playing, press the Space Bar to watch again and sing along.\n' ...
		'Press the Space Bar to start.' ...
		];
showInstructions(state, text);

% nmatMetronome = generateMidiGrid(state, state.blocks.(blockName).metronome);
nmatMetronome = getMetronome(state, state.blocks.(blockName).metronome);
metronomeDuration = getMetronomeDuration(nmatMetronome);

nmatMelody = generateMidiGrid(state, state.blocks.(blockName).midi);

nmatMetronomeAndMelody = concatenateMetronomeAndMelody(nmatMetronome, nmatMelody);

% Calculate the onset landmark, in milliseconds, of each note and text change
wordTimes = getWordTimes(state, blockName, nmatMelody);

% bpmeasure = state.blocks.(blockName).beatsPerMeasure;
% frameName = ['sentenceFrame', num2str(bpmeasure)];
frameName = ['sentenceFrame', blockName(1)];
sentenceFrame = state.(frameName);

nTrainingWords = numel(state.trainingWords);
trainingOrder = randperm(nTrainingWords); % randomly ordered integers from 1 through nTrainingWords

for iTrainingWord = 1:nTrainingWords
	targetWord = state.trainingWords{trainingOrder(iTrainingWord)};
	
% Watch and listen
	prepareAudio(state, nmatMetronomeAndMelody);
	
	text = ['Remember: watch and listen first, then practice.\n' ...
			'Press the Space Bar to start.' ...
			];
	showInstructions(state, text);
	
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);

	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration);

	for iNote = 1:size(wordTimes, 1)
		showSentence(state, targetWord, iNote, nmatMelody, sentenceFrame, wordTimes);
	end
	
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);

	KbStrokeWait;
	
% Now you try
	prepareAudio(state, nmatMetronome);
	
	text = ['Now you try.\n' ...
			'Press the Space Bar to start.' ...
			];
	showInstructions(state, text);
	
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);
% 	[VBLTimestamp, StimulusOnsetTime, FlipTimestamp] = showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);
% 	saveTimestamp(state, [VBLTimestamp StimulusOnsetTime FlipTimestamp], targetWord);
	
	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration);

	for iNote = 1:size(wordTimes, 1)
		showSentence(state, targetWord, iNote, nmatMelody, sentenceFrame, wordTimes);
	end
	
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);

	KbStrokeWait;
end

end