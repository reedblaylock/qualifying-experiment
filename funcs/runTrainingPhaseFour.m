function runTrainingPhaseFour(state, blockName)
% Instructions
text = ['IMPORTANT\n' ...
        'This time, there will only be six beeps, and the text won''t turn red.\n' ...
        'The six beeps will cue you to start talking, just like before.\n' ...
        'Press the Space Bar to start.' ...
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