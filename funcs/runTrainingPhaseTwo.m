function runTrainingPhaseTwo(state, blockName)
% Hear a melody (x3)
% nmatMetronome = generateMidiGrid(state, state.blocks.(blockName).metronome);
nmatMetronome = getMetronome(state, state.blocks.(blockName).metronome);
nmatMelody = generateMidiGrid(state, state.blocks.(blockName).midi);
nmat = concatenateMetronomeAndMelody(nmatMetronome, nmatMelody);

% nmat = generateMidiGrid(state, state.blocks.(blockName).midi);

prepareAudio(state, nmat);

% Instructions
text = ['Listen to the melody 3 times.\n' ...
		'When the melody has finished playing, you may take a moment to try to sing it.\n' ...
		'Then, press the Space Bar to listen again.\n' ...
		'Press the Space Bar start listening.' ...
		];
showInstructions(state, text);

% Listen
Screen('Flip', state.win);
for iPlayCounter = 1:3
	% Start audio playback
	playAudio(state);

	WaitSecs(getMidiDuration(nmat));
	KbStrokeWait;
end
	
end