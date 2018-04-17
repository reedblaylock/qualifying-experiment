function runSpeechPhase(state, blockName)

text = ['Say each sentence aloud, then press the Space Bar to move to the next sentence.\n' ...
        'You should read each sentence casually.\n' ...
		'Press the Space Bar to begin.' ...
		];
showInstructions(state, text);

sentenceFrame = state.frame.(blockName);

nTargetWords = numel(state.targetWords);
targetOrder = [];

for iRepetition = 1:state.nTargetRepetitions
	targetOrder = randpermNoConsecutiveAfter(targetOrder, nTargetWords); % quasi-randomly ordered integers from 1 through nTrainingWords, with restrictions
	
	for iTargetWord = 1:nTargetWords
		targetWord = state.targetWords{targetOrder(iTargetWord)};
        
        saveTrialDetails(state, blockName, iRepetition, targetWord, 'speech')

		showStaticSentence(state, targetWord, sentenceFrame);

		KbStrokeWait;
	end
end

end