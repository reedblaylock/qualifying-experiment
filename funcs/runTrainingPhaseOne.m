function runTrainingPhaseOne(state, blockName, blockOrder)
%% Play the metronome
% Get audio
[snd, nmatMetronome] = getMetronome(state, blockName);

% Prepare audio
PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);

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

% Play audio
playAudio(state);

% Wait until audio is done playing + 1 second, then continue
midiDuration = getMidiDuration(nmatMetronome);
WaitSecs(midiDuration);
PsychPortAudio('Stop', state.pahandle);
WaitSecs(1);

%% Play the melody
% Get audio
[snd, nmatMelody] = getMelody(state, blockName);

% Prepare audio
PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);

% Show instructions
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

% Play audio
playAudio(state);

% Wait until audio is done playing + 1 second, then continue
midiDuration = getMidiDuration(nmatMelody);
WaitSecs(midiDuration);
PsychPortAudio('Stop', state.pahandle);
WaitSecs(1);

%% Play the melody with metronome
% Get audio
[snd, nmatMelodyWithMetronome] = getMelodyWithMetronome(state, blockName);

% Prepare audio
PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);

% Show instructions
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

% Play audio
playAudio(state);

% Wait until audio is done playing + 1 second, then continue
midiDuration = getMidiDuration(nmatMelodyWithMetronome);
WaitSecs(midiDuration);
PsychPortAudio('Stop', state.pahandle);
WaitSecs(1);

end