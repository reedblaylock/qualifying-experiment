function runTrainingPhaseThree(state, blockName)
% Instructions
text = ['Now you will learn how to fit words to beat.\n' ...
        'First, learn how to match every word to a beat by listening and watching.\n' ...
		'Then, when the beat is over, press the Space Bar to watch again and sing along.\n' ...
        'Press the Space Bar to continue.\n' ...
        ];
showInstructions(state, text);
text = [
		'Underlined words mark the beginning of groups of 3 syllables, and should be emphasized.\n' ...
        'If you want to keep the beat on your body, you can tap your finger quietly against your leg.\n' ...
		'Press the Space Bar to watch and listen.' ...
		];
showInstructions(state, text);

% Get music
[sndMelodyWithMetronome] = getMelodyWithMetronome(state, blockName);
[sndMetronome] = getMetronome(state, blockName);
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
	
    if iTrainingWord > 1
        text = ['Remember: watch and listen first, then practice.\n' ...
                'Press the Space Bar to start.' ...
                ];
        showInstructions(state, text);
    end
	
	showStaticSentence(state, targetWord, sentenceFrame);

	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration-state.avcorrection);

	for iNote = 1:size(wordTimes, 1)
		showSentence(state, targetWord, iNote, nmatMelody, sentenceFrame, wordTimes);
	end
	
	showStaticSentence(state, targetWord, sentenceFrame);

	KbStrokeWait;
	
	% Sing...
	% Prepare audio
    state = prepareAudio(state, sndMelodyWithMetronome);
	
	text = ['Now you try.\n' ...
			'Remember that the underlined words mark the beginning of groups of 3 syllables, and should be emphasized.\n' ...
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