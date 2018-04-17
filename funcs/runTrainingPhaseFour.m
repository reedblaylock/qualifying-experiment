function runTrainingPhaseFour(state, blockName)
% Instructions
text = ['Now, the metronome will play at first, but stop before the words begin.\n' ...
        'Let the end of the metronome cue the beginning of the words, like before.\n' ...
        'Press the Space Bar to continue.' ...
        ];
showInstructions(state, text);
text = ['Remember, the underlined words mark the beginning of groups of 3 syllables, and should be emphasized.\n' ...
        'If you want to keep the beat on your body, you can tap your finger quietly against your leg.\n' ...
		'Press the Space Bart to start.' ...
		];
showInstructions(state, text);

% Get music
[sndMetronome] = getMetronome(state);
metronomeDuration = getSoundDuration(state, sndMetronome);

% Prepare audio
state = prepareAudio(state, sndMetronome);

sentenceFrame = state.frame.(blockName);

% Randomize words
nTrainingWords = numel(state.trainingWords);
trainingOrder = randperm(nTrainingWords); % randomly ordered integers from 1 through nTrainingWords

for iTrainingWord = 1:nTrainingWords
	targetWord = state.trainingWords{trainingOrder(iTrainingWord)};
	
% Practice singing
	showStaticSentence(state, targetWord, sentenceFrame);

	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration+3);

	KbStrokeWait;
end

end