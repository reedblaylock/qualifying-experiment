function runTrainingPhaseTwo(state, blockName)
% Hear a melody (x3)
% [snd, nmat] = getMelodyWithMetronome(state, blockName);
[snd, nmat] = getMelody(state, blockName);

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
for iPlayCounter = 1:3
	Screen('Flip', state.win);
    
    % Start audio playback
	playAudio(state);

	WaitSecs(getMidiDuration(nmat));
% 	PsychPortAudio('Stop', state.pahandle);
    if iPlayCounter < 3
        showInstructions(state, 'Press the Space Bar to listen again.');
    elseif iPlayCounter == 3
        showInstructions(state, 'Press the Space Bar to continue.');
    end
end
	
end