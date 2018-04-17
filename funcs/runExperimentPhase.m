function runExperimentPhase(state, blockName)
% Instructions
text = ['Say the sentences on the screen, just like before.\n' ...
        'When you have finished saying each sentence, prace the Space Bar to continue.\n' ...
		'Press the Space Bar to begin.' ...
		];
showInstructions(state, text);

% Get music
[sndMetronome] = getMetronome(state);
metronomeDuration = getSoundDuration(state, sndMetronome);

% Prepare audio
state = prepareAudio(state, sndMetronome);

sentenceFrame = state.frame.(blockName);

% Prepare target words
nTargetWords = numel(state.targetWords);
targetOrder = [];

for iRepetition = 1:state.nTargetRepetitions
	targetOrder = randpermNoConsecutiveAfter(targetOrder, nTargetWords); % quasi-randomly ordered integers from 1 through nTrainingWords, with restrictions
	
	for iTargetWord = 1:nTargetWords
		targetWord = state.targetWords{targetOrder(iTargetWord)};
        
        saveTrialDetails(state, blockName, iRepetition, targetWord, 'chanting');

		showStaticSentence(state, targetWord, sentenceFrame);
		
		% Start audio playback
		playAudio(state);
		WaitSecs(metronomeDuration+3);

		KbStrokeWait;
	end
end

end