function runTrainingPhaseOne(state)
%% Play the metronome
% Get audio
[snd, ~] = getMetronome(state);
state = prepareAudio(state, snd);

% Show instructions
text = 'Before every elicitation, there will be a metronome.\n';
text = [text ...
		'The metronome is made of two groups of 3 notes.\n' ...
		];
text = [text ...
		'Press the Space Bar to listen.\n' ...
        'When the metronome stops playing, press the Space Bar to continue.' ...
		];
showInstructions(state, text);

% Play audio
playAudio(state);

% Wait until audio is done playing + 1 second, then continue
midiDuration = getSoundDuration(snd);
WaitSecs(midiDuration);
KbStrokeWait;

end