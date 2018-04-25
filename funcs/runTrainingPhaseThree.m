function runTrainingPhaseThree(state, blockName)
% Instructions
text = ['Now you will practice fitting words to beat.\n' ...
        'First, listen and watch.\n' ...
		'Then, when the beat is over, press the Space Bar to speak along with the metronome.\n' ...
        'Press the Space Bar to continue.\n' ...
        ];
showInstructions(state, text);
text = [
		'Underlined words mark the beginning of groups of 3 syllables, and should be emphasized.\n' ...
        'Press the Space Bar to watch and listen.' ...
		];
showInstructions(state, text);

% Get music
[sndMelodyWithMetronome] = getMelodyWithMetronome(state);
[sndMetronome] = getMetronome(state);
[sndMelody] = getMelody(state);
metronomeDuration = getSoundDuration(state, sndMetronome);

% Calculate the onset landmark, in milliseconds, of each note and text change
wordTimes = getWordTimes2(state, blockName, sndMelody);

sentenceFrame = state.frame.(blockName);

% Randomize words
nTrainingWords = numel(state.trainingWords);
trainingOrder = randperm(nTrainingWords); % randomly ordered integers from 1 through nTrainingWords

for iTrainingWord = 1:nTrainingWords
	% Listen...
	targetWord = state.trainingWords{trainingOrder(iTrainingWord)};
	
	% Prepare audio
	state = prepareAudio(state, sndMelodyWithMetronome);
	
    text = ['Watch and listen.\n' ...
            'The words start after the first six beeps of the metronome.\n' ...
            'Press the Space Bar to start.' ...
            ];
    showInstructions(state, text);
	
	showStaticSentence(state, targetWord, sentenceFrame);

	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration-state.avcorrection);

	for iNote = 1:size(wordTimes, 1)
		showSentence(state, targetWord, iNote, sentenceFrame, wordTimes);
	end
	
	showStaticSentence(state, targetWord, sentenceFrame);

	KbStrokeWait;
	
	% Sing...
	% Prepare audio
    state = prepareAudio(state, sndMelodyWithMetronome);
	
	text = ['Speak with the metronome.\n' ...
            'Start talking after the first six beeps of the metronome.\n' ...
			'Press the Space Bar to start.' ...
			];
	showInstructions(state, text);
	
	showStaticSentence(state, targetWord, sentenceFrame);
	
	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration);
	
	for iNote = 1:size(wordTimes, 1)
		showSentence(state, targetWord, iNote, sentenceFrame, wordTimes);
	end
	
	showStaticSentence(state, targetWord, sentenceFrame);

	KbStrokeWait;
end

end