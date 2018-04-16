 % Experiment
% Reed Blaylock, 2017

% This experiment depends on
% - Psychtoolbox 3.0.14 (http://psychtoolbox.org/)
% - MIDI Toolbox 1.1 (https://github.com/miditoolbox/1.1)

%% Clear the workspace and the screen
sca;
close all;
clearvars;

try % Covers the whole experiment
%% Get participant information
nPreviousParticipants = getNumPreviousParticipants();

prompt = {'Participant ID', 'Researcher ID'};
dlg_title = 'Study information';
num_lines = 1;
defaultans = {num2str(nPreviousParticipants + 1), 'RB'};
answer = inputdlg(prompt, dlg_title, num_lines, defaultans);

participantId = answer{1};
researcherId = answer{2};

%% If participantId already exists, rename the old folder just in case
protectOldFolder(participantId);

%% Initialize everything
state = generateState(participantId, researcherId);

% Choose blocking order based on number of previous participants of this
% voiceType
blockOrderName = 'order1';
blockOrder = state.blockOrders.(blockOrderName);

% Save block order, participant ID, etc
savePreliminaryStudyData(state, blockOrderName);

%% Present initial instructions
% text = 'In this experiment, you will speak and sing some sentences.\nYou do not have to be "good" at singing to do this experiment.\nPress the Space Bar when you are ready to start.';
text = ['In this experiment, you will say some sentences.\n' ...
		'Sometimes, you will be asked to speak to a beat. Other times, you will just speak as you normally would.\n' ...
		'You will be asked to take a break half-way through the experiment. You can also pause whenever you need to.\n' ...
		'Press the Space Bar when you are ready to start.' ...
		];
showInstructions(state, text);

%% Run everything
nBlocks = numel(state.blockNames);
for iBlock = 1:nBlocks
	blockName = state.blockNames{blockOrder(iBlock)};

    runTrainingPhaseOne(state);
    
	participantHasBeenTrained = 0;
	nTrainingIterations = 0;
    while ~participantHasBeenTrained
% Run training phase
		
		runTrainingPhaseThree(state, blockName);
		runTrainingPhaseFour(state, blockName);

% Get input: are you comfortable with this?
		nTrainingIterations = nTrainingIterations + 1;
		participantHasBeenTrained = getParticipantConfidence(state);
    end
    
    noteTrainingIterations(state, nTrainingIterations);

% Run experiment phase
	runExperimentPhase(state, blockName);
end

% Give them a break
runBreak(state);

% Run both speech phases
for iBlock = 1:nBlocks
   runSpeechPhase(state, blockName); 
end

% Note that the experiment was finished
noteStudyFinished(state);

%% Thank you screen
text = ['Thank you for participating!\n' ...
		'Please let the attending scientist know that you are finished with this part of the experiment.' ...
		];
showInstructions(state, text);

%% Exit
sca;

catch err
	if exist('state', 'var')
		recordCrash(state);
	end
	
	sca;
	
	rethrow(err);
end