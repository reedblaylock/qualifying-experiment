function state = generateState(participantId, researcherId)
%% Sound settings

% Initialize Sounddriver
InitializePsychSound(1);

% Number of channels and Frequency of the sound
state.nrchannels = 2;
state.nrchannelsInput = 1;
state.freq = 44100;

% How many times to we wish to play the sound
state.repetitions = 1;

% Length of the pause between beeps
% state.beepPauseTime = 1;

% Start immediately (0 = immediately)
state.startCue = 0;

% Should we wait for the device to really start (1 = yes)
% INFO: See help PsychPortAudio
state.waitForDeviceStart = 1;

% Open Psych-Audio port, with the follow arguements
% (1) [] = default sound device
% (2) 1 = sound playback only
% (3) 1 = default level of latency
% (4) Requested frequency in samples per second
% (5) 2 = stereo putput
% state.pahandle = PsychPortAudio('Open', [], 1, 1, state.freq, state.nrchannels);
% state.pahandleInput = PsychPortAudio('Open', [], 2, 0, state.freq, state.nrchannelsInput);

% Set the volume to half for this demo
% PsychPortAudio('Volume', state.pahandle, 0.5);

state.avcorrection = 0.05;

%% Screen settings

% TODO: Development only: don't worry about perfect frame synchronization
% Screen('Preference','SkipSyncTests', 1);

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer. For example, when I call this I get the vector
% [0 1]. The first number is the native display for my laptop and the
% second referes to my secondary external monitor. By native display I mean
% the display the is physically part of my laptop. With a non-laptop
% computer look at your screen preferences to see which is the primary
% monitor.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. If I were to select the minimum of these numbers then I would be
% displaying on the physical screen of my laptop.
state.screenNumber = max(screens);

% Define black and white (white will be 1 and black 0). This is because
% luminace values are genrally defined between 0 and 1.
state.white = WhiteIndex(state.screenNumber);
state.black = BlackIndex(state.screenNumber);

% Do a simply calculation to calculate the luminance value for grey. This
% will be half the luminace value for white
state.grey = state.white / 2;

% Open a window with a gray background
[state.win, state.winRect] = PsychImaging('OpenWindow', state.screenNumber, state.grey);

% Query the frame duration
state.ifi = Screen('GetFlipInterval', state.win);

% Set the blend function for the screen
Screen('BlendFunction', state.win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%% Block settings

state.blockNames = {'aligned', 'misaligned'};

state.beatsPerMeasure = 3;

state.files.wav.metronome2 = ['wav' filesep 'metronome2.wav'];
state.files.wav.metronome8 = ['wav' filesep 'metronome8.wav'];
state.files.wav.metronome10 = ['wav' filesep 'metronome10.wav'];
state.files.midi = ['midi' filesep 'metronome34.mid'];

state.blockOrders.order1 = [1 2];
state.blockOrders.order2 = [2 1];

state.trainingWords = { ...
  {'Ti-', 'pa-', 'pa'}, ...
};

state.targetWords = { ...
  {'Brou-', 'ha-', 'ha'}, ...
  {'Oom-', 'pa-', 'pa'} ...
};

state.nTargetRepetitions = 3;

state.frame.aligned = {'See', 'you', 'in', '', '', '.', 'Have', 'a', 'good', 'ho-', 'li-', 'day.'};
% state.sentenceFrameAToNmatMap = [1, 2, 3, 4, 5, 6, 0, 7, 8, 9, 10, 11];
state.frame.misaligned = {'See', 'you', 'there.', '', '', '', 'is', 'a', 'good', 'ho-', 'li-', 'day.'};
% state.sentenceFrameBToNmatMap = [1, 2, 3, 4, 5, 6, 7, 8, 0, 9, 10, 11];

state.midiType = 'fm';
% state.midiType = 'shepard'; % sounds weird...
state.midiSamplingRate = state.freq;

state.maxAmplitude = 112;
state.amplitudeRatio = 3; % louderAmplitude = quietAmplitude * state.amplitudeRatio

%% Other settings

state.audioPrePlayPauseDuration = 0.25;
state.participantsFolder = 'participants';
state.recordingFolder = 'wav';

state.participantId = participantId;
state.researcherId = researcherId;

end