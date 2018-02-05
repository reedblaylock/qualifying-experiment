function participantConfidence = getParticipantConfidence(state)
% Adapted from https://github.com/Psychtoolbox-3/Psychtoolbox-3/wiki/Cookbook:-response-example-3

% Set some text styles
applyDefaultTextStyles(state.win);

text = ['Would you like to go through the training again?\n' ...
		'If you believe you have learned the melody and how to match it to words, press the "N" key.\n' ...
		'Otherwise, if you would like to go through the training again, press the "Y" key.\n' ...
		];
DrawFormattedText(state.win, text, 50, 'center', [], [], [], [], 2);

% ListenChar(2); %makes it so characters typed don?t show up in the command window

%Get responses from what subjects typed
KbName('UnifyKeyNames'); %used for cross-platform compatibility of keynaming
% KbQueueCreate; %creates cue using defaults
% KbQueueStart;  %starts the cue

keyY = KbName('Y'); % define "Y" key (used to proceed)
keyN = KbName('N'); % define "N" key (used to keep going)

Screen('Flip', state.win);

answerGiven = 0;
while ~answerGiven
	[~, pressedKeys, ~] = KbWait();
	yWasPressed = pressedKeys(keyY);
	nWasPressed = pressedKeys(keyN);
	
	if ((yWasPressed || nWasPressed) && ~(yWasPressed && nWasPressed))
		answerGiven = 1;
		if nWasPressed
			participantConfidence = 1;
		else
			participantConfidence = 0;
		end
	end
	
	WaitSecs(.01); % put in small interval to allow other system events
end

% ListenChar(0); %makes it so characters typed do show up in the command window

end