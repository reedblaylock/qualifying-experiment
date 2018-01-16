 % Experiment
% Reed Blaylock, 2017

% This experiment depends on
% - Psychtoolbox 3 (http://psychtoolbox.org/)
% - MIDI Toolbox 1.1 (https://github.com/miditoolbox/1.1)

%% TODO: Get verification that you're doing the right voice part changes --GET A PROFESSIONAL TO TELL YOU WHAT NOTES
% http://www.rawilliamsmusic.com/essays/Essay_Range.html

%% TODO: Finish instructions
% - Make sure they fit on the screen
% - Make sure they make sense

%% Clear the workspace and the screen
sca;
close all;
clearvars;

try % Covers the whole experiment
%% Get participant information
nPreviousParticipants = getNumPreviousParticipants();

prompt = {'Voice type ("high" or "low")', 'Participant ID', 'Researcher ID'};
dlg_title = 'Study information';
num_lines = 1;
defaultans = {'low', num2str(nPreviousParticipants + 1), 'RB'};
answer = inputdlg(prompt, dlg_title, num_lines, defaultans);

voiceType = answer{1};
participantId = answer{2};
researcherId = answer{3};

%% If participantId already exists, rename the old folder just in case
protectOldFolder(participantId);

%% Initialize everything
state = generateState(participantId, voiceType, researcherId);

switch voiceType
	case 'high'
		nVoiceType = countVoiceType('high');
	case 'low'
		nVoiceType = countVoiceType('low');
	otherwise
		error('Invalid voice type');
end

% % TODO: This is a hacky way to get at the high/low values. You should really go
% % through each folder and count the number of highs and lows you've already
% % recorded from the info file
% load('nHigh.mat');
% load('nLow.mat');
% 
% switch voiceType
% 	case 'high'
% 		nVoiceType = nHigh;
% 	case 'low'
% 		nVoiceType = nLow;
% 	otherwise
% 		error('Invalid voice type');
% end

% Choose blocking order based on number of previous participants of this
% voiceType
blockOrderName = ['order' num2str(mod(nVoiceType, numel(fieldnames(state.blockOrders))) + 1)];
blockOrder = state.blockOrders.(blockOrderName);

% Save block order, participant ID, etc
savePreliminaryStudyData(state, blockOrderName);

%% Present initial instructions
% text = 'In this experiment, you will speak and sing some sentences.\nYou do not have to be "good" at singing to do this experiment.\nPress the Space Bar when you are ready to start.';
text = ['In this experiment, you will speak and sing some sentences.\n' ...
		'In the singing phase, you will learn a melody to use for the sentences.\n' ...
		'You can take a break any time during the experiment. There will also be times when you are asked to take a break.\n' ...
		'Press the Space Bar when you are ready to start.' ...
		];
showInstructions(state, text);

%% Run everything
nBlocks = numel(state.blockNames);
for iBlock = 1:nBlocks
	blockName = state.blockNames{blockOrder(iBlock)};

%	Run the speech recording part on the 1st and 3rd blocks presented
	if (mod(iBlock, 2))
% 		[VBLTimestamps, StimulusOnsetTimes, FlipTimestamps] = run   SpeechPhase(state, blockName);
		runSpeechPhase(state, blockName);
	end
	
	participantHasBeenTrained = 0;
	nTrainingIterations = 0;
	while ~participantHasBeenTrained
% Run training phase
		runTrainingPhaseOne(state, blockName, blockOrder);
		runTrainingPhaseTwo(state, blockName);
		runTrainingPhaseThree(state, blockName);
		runTrainingPhaseFour(state, blockName);

% Get input: are you comfortable with this?
		nTrainingIterations = nTrainingIterations + 1;
		participantHasBeenTrained = getParticipantConfidence(state);
	end

% Run experiment phase
	runExperimentPhase(state, blockName);

	if iBlock ~= nBlocks
		runBreak(state);
	end
end

%% Cleanup
% Close the audio device
PsychPortAudio('Close', state.pahandle);
PsychPortAudio('Close', state.pahandleInput);

% Note that the experiment was finished
noteStudyFinished(state, nTrainingIterations);

% Keep track of how many of each voice type have been recorded
switch voiceType
	case 'high'
		nHigh = nHigh + 1;
	case 'low'
		nLow = nLow + 1;
	otherwise
		error('Invalid voice type selected');
end

% save('nHigh.mat', 'nHigh');
% save('nLow.mat', 'nLow');

%% Thank you screen
text = ['Thank you for singing!\n' ...
		'Please let the attending scientist know that you are finished with this part of the experiment.' ...
		];
showInstructions(state, text);

%% Exit
sca;

catch err
	if exist('state', 'var')
		if isfield(state, 'pahandle')
			PsychPortAudio('Close', state.pahandle);
		end
		if isfield(state, 'pahandleInput')
			PsychPortAudio('Close', state.pahandleInput);
		end
		
		recordCrash(state);
	end
	
	sca;
	
	rethrow(err);
end