function runExperimentPhase(state, blockName)
% Instructions
text = ['Sing the melody to the words on the screen, just like before.\n' ...
		'Press the Space Bar to begin.' ...
		];
showInstructions(state, text);

% Get music
[snd, nmatMetronome] = getMetronome(state, blockName);
[~, nmatMelody] = getMelody(state, blockName);
metronomeDuration = getMetronomeDuration(nmatMetronome);

% Prepare audio
PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);

% Calculate the onset landmark, in milliseconds, of each note and text change
wordTimes = getWordTimes(state, blockName, nmatMelody);
frameName = ['sentenceFrame', blockName(1)];
sentenceFrame = state.(frameName);

% Prepare target words
nTargetWords = numel(state.targetWords);
targetOrder = [];

% % Preallocate an internal audio recording  buffer with a capacity of 10 seconds:
% bufferSize = 10;
% PsychPortAudio('GetAudioData', state.pahandleInput, bufferSize);

for iRepetition = 1:state.nTargetRepetitions
	targetOrder = randpermNoConsecutiveAfter(targetOrder, nTargetWords); % quasi-randomly ordered integers from 1 through nTrainingWords, with restrictions
	
	for iTargetWord = 1:nTargetWords
		targetWord = state.targetWords{targetOrder(iTargetWord)};

		showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);
		
% 		% Start audio recording
% 		PsychPortAudio('Start', state.pahandleInput, 0, 0, 1);
% 		
% 		% Start with empty sound vector:
% 		recordedaudio = [];
% 		
% 		% We retrieve status once to get access to SampleRate:
% 		s = PsychPortAudio('GetStatus', state.pahandleInput);
		
		% Start audio playback
		playAudio(state);
		WaitSecs(metronomeDuration);
		PsychPortAudio('Stop', state.pahandle);
		
% 		while ~KbCheck && ((length(recordedaudio) / s.SampleRate) < inf)
% 			% Wait a second...
% 			WaitSecs(.1);
% 
% 			% Query current capture status and print it to the Matlab window:
% 			s = PsychPortAudio('GetStatus', state.pahandleInput);
% 
% 			% Retrieve pending audio data from the drivers internal ringbuffer:
% 			audiodata = PsychPortAudio('GetAudioData', state.pahandleInput);
% 
% 			% And attach it to our full sound vector:
% 			recordedaudio = [recordedaudio audiodata]; %#ok<AGROW>
% 		end
% 		
% 		% Add a small buffer to make sure you get the last of the recording
% 		WaitSecs(.1);
% 		
% 		% Stop capture:
% 		PsychPortAudio('Stop', state.pahandleInput);
% 
% 		% Perform a last fetch operation to get all remaining data from the capture engine:
% 		audiodata = PsychPortAudio('GetAudioData', state.pahandleInput);
% 
% 		% Attach it to our full sound vector:
% 		recordedaudio = [recordedaudio audiodata]; %#ok<AGROW>
% 		saveAudio(state, recordedaudio, blockName, targetWord, iRepetition, 'sung');

		KbStrokeWait;
		% TODO: stop audio
	end
end

end