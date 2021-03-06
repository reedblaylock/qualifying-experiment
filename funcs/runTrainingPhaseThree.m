function runTrainingPhaseThree(state, blockName)
nNotes = blockName(end);
% Instructions
text = ['In the next section, you will learn how to fit words to the melody.\n' ...
        'First, learn how to match every word to a note by listening and watching.\n' ...
		'Then, when the melody has finished playing, press the Space Bar to watch again and sing along.\n' ...
        'Press the Space Bar to continue.\n' ...
        ];
showInstructions(state, text);
text = [
		'Underlined words mark the beginning of groups of ' nNotes ' notes or silences, and should be emphasized.\n' ...
        'Please sing without any flourishes or embellishments.\n' ...
        'If you want to keep the beat on your body, you can tap your finger quietly against your leg.\n' ...
		'Press the Space Bar to watch and listen.' ...
		];
showInstructions(state, text);

% Get music
% [sndMelodyWithMetronome, nmatMelodyWithMetronome] = getMelodyWithMetronome(state, blockName);
[sndMelodyWithMetronome, ~] = getMelodyWithMetronome(state, blockName);

% [sndMetronome, nmatMetronome] = getMetronome(state, blockName);
[sndMetronome, ~] = getMetronome(state, blockName);

[sndMelody, nmatMelody] = getMelody(state, blockName);

% metronomeDuration = getMetronomeDuration(nmatMetronome);
metronomeDuration = getSoundDuration(state, sndMetronome);

% melodyWithMetronomeDuration = getMidiDuration(nmatMelodyWithMetronome);

% Calculate the onset landmark, in milliseconds, of each note and text change
% wordTimes = getWordTimes(state, blockName, nmatMelody);
wordTimes = getWordTimes2(state, blockName, sndMelody);

frameName = ['sentenceFrame', blockName(1)];
sentenceFrame = state.(frameName);

% Randomize words
nTrainingWords = numel(state.trainingWords);
trainingOrder = randperm(nTrainingWords); % randomly ordered integers from 1 through nTrainingWords

for iTrainingWord = 1:nTrainingWords
	% Listen...
	targetWord = state.trainingWords{trainingOrder(iTrainingWord)};
	
	% Prepare audio
% 	PsychPortAudio('FillBuffer', state.pahandle, [sndMelodyWithMetronome; sndMelodyWithMetronome]);
	state = prepareAudio(state, sndMelodyWithMetronome);
	
    if iTrainingWord > 1
        text = ['Remember: watch and listen first, then practice.\n' ...
                'Press the Space Bar to start.' ...
                ];
        showInstructions(state, text);
    end
	
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);

	% Start audio playback
	playAudio(state);
	WaitSecs(metronomeDuration-state.avcorrection);

	for iNote = 1:size(wordTimes, 1)
		showSentence(state, targetWord, iNote, nmatMelody, sentenceFrame, wordTimes);
	end
	
	showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);

% 	PsychPortAudio('Stop', state.pahandle);
	KbStrokeWait;
	% TODO: Stop audio
	
	% Sing...
	% Prepare audio
% 	PsychPortAudio('FillBuffer', state.pahandle, [sndMetronome; sndMetronome]);
% 	state = prepareAudio(state, sndMetronome);
    state = prepareAudio(state, sndMelodyWithMetronome);
	
	text = ['Now you try.\n' ...
			'Remember that the underlined words mark the beginning of groups of ' nNotes ' notes or silences, and should be emphasized.\n' ...
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

% 	PsychPortAudio('Stop', state.pahandle);
	KbStrokeWait;
end

end