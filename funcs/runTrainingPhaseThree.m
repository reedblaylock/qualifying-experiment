function runTrainingPhaseThree(state, blockName)
nNotes = blockName(end);
% Instructions
text = ['In the next examples, the melody will be matched to words.\n' ...
		'Underlined words mark the beginning of groups of ' nNotes ' notes, just like the metronome.\n' ...
		'Learn how to match every word to a note by listening and watching.\n' ...
		'When the melody has finished playing, press the Space Bar to watch again and sing along.\n' ...
		'Press the Space Bar to start.' ...
		];
showInstructions(state, text);

% Get music
[sndMelodyWithMetronome, nmatMelodyWithMetronome] = getMelodyWithMetronome(state, blockName);
[sndMetronome, nmatMetronome] = getMetronome(state, blockName);
[~, nmatMelody] = getMelody(state, blockName);
metronomeDuration = getMetronomeDuration(nmatMetronome);
melodyWithMetronomeDuration = getMidiDuration(nmatMelodyWithMetronome);

% Calculate the onset landmark, in milliseconds, of each note and text change
wordTimes = getWordTimes(state, blockName, nmatMelody);
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
	prepareAudio(state, sndMelodyWithMetronome);
	
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

% 	PsychPortAudio('Stop', state.pahandle);
	KbStrokeWait;
	% TODO: Stop audio
	
	% Sing...
	% Prepare audio
% 	PsychPortAudio('FillBuffer', state.pahandle, [sndMetronome; sndMetronome]);
	prepareAudio(state, sndMetronome);
	
	text = ['Now you try.\n' ...
			'Remember that the underlined words mark the beginning of groups of ' nNotes ' notes.\n' ...
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