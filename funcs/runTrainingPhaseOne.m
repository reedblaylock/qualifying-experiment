function runTrainingPhaseOne(state)
%% Play the metronome
% Get audio
[snd] = getMetronome(state);
state = prepareAudio(state, snd);

% Show instructions
text = 'Before every elicitation, there will be a metronome.\n';
text = [text ...
		'The metronome is made of six beeps: two groups of three.\n' ...
        'The first beep in a group is louder than the other two.\n' ...
        'Press the Space Bar to continue.\n' ...
		];
showInstructions(state, text);
text = ['Press the Space Bar to listen to the metronome.\n' ...
        'When the metronome stops playing, press the Space Bar to continue.' ...
		];
showInstructions(state, text);

yn = 1;
nTries = 0;
while yn
    Screen('Flip', state.win);
    
    % Play audio
    playAudio(state);

    % Wait until audio is done playing + 1 second, then continue
    midiDuration = getSoundDuration(state, snd);
    WaitSecs(midiDuration+0.5);

    if nTries < 5
        yn = askYesNo(state, 'Would you like to hear the metronome again?');
    else
        yn = 0;
    end
    nTries = nTries + 1;
end

% KbStrokeWait;

end