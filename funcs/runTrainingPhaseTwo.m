function runTrainingPhaseTwo(state, blockName)
% Hear a melody (x3)
[snd, nmat] = getMelodyWithMetronome(state, blockName);

% Prepare audio
% PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);
state = prepareAudio(state, snd);

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
% 	PsychPortAudio('Stop', state.pahandle);
	KbStrokeWait;
	% TODO: stop audio
end
	
end