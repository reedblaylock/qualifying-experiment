function runTrainingPhaseOne(state, blockName, blockOrder)
%% Play the metronome
% Generate next midi grid
% nmat = generateMidiGrid(state, state.blocks.(blockName).metronome);
nmat = getMetronome(state, state.blocks.(blockName).metronome);
nmatMetronome = nmat;

% Buffer the sound
prepareAudio(state, nmat);

% Show instructions
text = 'First, listen to the metronome.\n';
iBlockName = find(strcmp(state.blockNames, blockName));
if ~(blockOrder(1) == iBlockName) % This isn't your first time hearing a metronome
	text = [text ...
			'It may be different from metronomes you have already heard in this experiment.\n' ...
			];
end
text = [text ...
		'Press the Space Bar to listen.' ...
		];
showInstructions(state, text);

% Play the sound
playAudio(state);

% Click to continue
midiDuration = getMidiDuration(nmat);
WaitSecs(midiDuration + 1);
% KbStrokeWait;

%% Play the melody
% Generate next midi grid
nmat = generateMidiGrid(state, state.blocks.(blockName).midi);
nmatMelody = nmat;

% Buffer the sound
prepareAudio(state, nmat);

text = 'Next, listen to the melody.\n';
if ~(blockOrder(1) == iBlockName) % This isn't your first time hearing a melody
	text = [text ...
			'It may be different from melodies you have already heard in this experiment.\n' ...
			];
end
text = [text ...
		'Press the Space Bar to listen.' ...
		];
showInstructions(state, text);

% Play the sound
playAudio(state);

% Click to continue
midiDuration = getMidiDuration(nmat);
WaitSecs(midiDuration + 1);
% KbStrokeWait;

%% Play the metronome and melody together
% Generate next midi grid
nmat = concatenateMetronomeAndMelody(nmatMetronome, nmatMelody);

% Buffer the sound
prepareAudio(state, nmat);

text = ['Now, listen to the metronome and melody together.\n' ...
		'Press the Space Bar to listen.' ...
		];
showInstructions(state, text);

% Play the sound
playAudio(state);

% Click to continue
midiDuration = getMidiDuration(nmat);
WaitSecs(midiDuration + 1);
% KbStrokeWait;

end