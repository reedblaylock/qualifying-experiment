function runTrainingPhaseOne(state, blockName, blockOrder)
%% Play the metronome
% Get audio
[snd, nmatMetronome] = getMetronome(state, blockName);
% nmatTest = generateMidiGrid(state, state.blocks.(blockName).metronome.midi);
% sndTest = nmat2snd(nmatTest, state.midiType, state.midiSamplingRate);
% 
% sca;
% keyboard;

% Prepare audio
% PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);
state = prepareAudio(state, snd);

% Show instructions
text = 'First, listen to the metronome.\n';
iBlockName = find(strcmp(state.blockNames, blockName));
if ~(blockOrder(1) == iBlockName) % This isn't your first time hearing a metronome
	text = [text ...
			'It may be different from metronomes you have already heard in this experiment.\n' ...
			];
end
nNotes = blockName(end);
text = [text ...
		'This metronome is made of two groups of ' nNotes ' notes.\n' ...
		];
text = [text ...
		'Press the Space Bar to listen.\n' ...
        'When the metronome stops playing, press the Space Bar to continue.' ...
		];
showInstructions(state, text);

% Play audio
playAudio(state);

% Wait until audio is done playing + 1 second, then continue
midiDuration = getMidiDuration(nmatMetronome);
WaitSecs(midiDuration);
% PsychPortAudio('Stop', state.pahandle);
% WaitSecs(1);
KbStrokeWait;

%% Play the melody
% Get audio
[snd, nmatMelody] = getMelody(state, blockName);

% Prepare audio
% PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);
state = prepareAudio(state, snd);

% Show instructions
text = 'Next, listen to the melody.\n';
if ~(blockOrder(1) == iBlockName) % This isn't your first time hearing a melody
	text = [text ...
			'It may be different from melodies you have already heard in this experiment.\n' ...
			];
end
text = [text ...
		'Press the Space Bar to listen.\n' ...
        'When the melody stops playing, press the Space Bar to continue.' ...
		];
showInstructions(state, text);

% Play audio
playAudio(state);

% Wait until audio is done playing + 1 second, then continue
midiDuration = getMidiDuration(nmatMelody);
WaitSecs(midiDuration);
% PsychPortAudio('Stop', state.pahandle);
% WaitSecs(1);
KbStrokeWait;

%% Play the melody with metronome
% Get audio
[snd, nmatMelodyWithMetronome] = getMelodyWithMetronome(state, blockName);

% Prepare audio
% PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);
state = prepareAudio(state, snd);

% Show instructions
text = 'Now, listen to the metronome and melody together.\n';
if ~(blockOrder(1) == iBlockName) % This isn't your first time hearing a melody
	text = [text ...
			'Remember, they may be different from what you have already heard in this experiment.\n' ...
			];
end
text = [text ...
		'Press the Space Bar to listen.\n' ...
        'When the melody stops playing, press the Space Bar to continue.' ...
		];
showInstructions(state, text);

% Play audio
playAudio(state);

% Wait until audio is done playing + 1 second, then continue
midiDuration = getMidiDuration(nmatMelodyWithMetronome);
WaitSecs(midiDuration);
% PsychPortAudio('Stop', state.pahandle);
% WaitSecs(1);
KbStrokeWait;

end