function state = generateState(participantId, voiceType, researcherId)
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

state.blockNames = {'A3', 'A4', 'B3', 'B4'};
% state.blockNames = {'A3'};

state.blocks.A3.melody.wav = ['wav' filesep 'A3.wav'];
state.blocks.A3.melody.midi = ['midi' filesep 'A3.mid'];
state.blocks.A3.metronome.wav = ['wav' filesep 'metronome34.wav'];
state.blocks.A3.metronome.midi = ['midi' filesep 'metronome34.mid'];
state.blocks.A3.beatsPerMeasure = 3;

state.blocks.A4.melody.wav = ['wav' filesep 'A4.wav'];
state.blocks.A4.melody.midi = ['midi' filesep 'A4.mid'];
state.blocks.A4.metronome.wav = ['wav' filesep 'metronome44.wav'];
state.blocks.A4.metronome.midi = ['midi' filesep 'metronome44.mid'];
state.blocks.A4.beatsPerMeasure = 4;

state.blocks.B3.melody.wav = ['wav' filesep 'B3.wav'];
state.blocks.B3.melody.midi = ['midi' filesep 'B3.mid'];
state.blocks.B3.metronome.wav = ['wav' filesep 'metronome34.wav'];
state.blocks.B3.metronome.midi = ['midi' filesep 'metronome34.mid'];
state.blocks.B3.beatsPerMeasure = 3;

state.blocks.B4.melody.wav = ['wav' filesep 'B4.wav'];
state.blocks.B4.melody.midi = ['midi' filesep 'B4.mid'];
state.blocks.B4.metronome.wav = ['wav' filesep 'metronome44.wav'];
state.blocks.B4.metronome.midi = ['midi' filesep 'metronome44.mid'];
state.blocks.B4.beatsPerMeasure = 4;

state.blockOrders.order1 = [1 2 3 4];
state.blockOrders.order2 = [2 1 4 3];
state.blockOrders.order3 = [3 4 1 2];
state.blockOrders.order4 = [4 3 2 1];

state.trainingWords = { ...
  'cake', ...
  'fish', ...
  'tree'
};

state.targetWords = { ...
  'pie', ...
  'pine', ...
  'bee', ...
  'bean', ...
  'bow', ...
  'bone', ...
  'paw', ...
  'pawn' ...
};

%   'pay' ...
%   'pain' ...

state.nTargetRepetitions = 3;

state.sentenceFrameA = {'She', 'asked', 'me', 'for', 'a', '.', '', 'To-', 'day', 'there', 'were', 'none.'};
state.sentenceFrameAToNmatMap = [1, 2, 3, 4, 5, 6, 0, 7, 8, 9, 10, 11];
state.sentenceFrameB = {'She', 'asked', 'me', 'for', 'a', '', 'to-', 'day.', '', 'There', 'were', 'none.'};
state.sentenceFrameBToNmatMap = [1, 2, 3, 4, 5, 6, 7, 8, 0, 9, 10, 11];

state.midiType = 'fm';
% state.midiType = 'shepard'; % sounds weird...
state.midiSamplingRate = state.freq;

state.maxAmplitude = 112;
state.amplitudeRatio = 3; % louderAmplitude = quietAmplitude * state.amplitudeRatio

%% Other settings

state.voiceType = voiceType;
state.voiceTypeInterval = 12; % increase of 12 semitones (base is C3(?))
state.audioPrePlayPauseDuration = 0.25;
state.participantsFolder = 'participants';
state.recordingFolder = 'wav';

state.participantId = participantId;
state.researcherId = researcherId;

end