function [VBLTimestamps, StimulusOnsetTimes, FlipTimestamps] = runSpeechPhase(state, blockName)

VBLTimestamps = [];
StimulusOnsetTimes = [];
FlipTimestamps = [];

text = ['Say each sentence aloud, then press the Space Bar to move to the next sentence.\n' ...
		'Press the Space Bar to begin.' ...
		];
showInstructions(state, text);

% nmatMetronome = generateMidiGrid(state, state.blocks.(blockName).metronome);
% metronomeDuration = getMetronomeDuration(nmatMetronome);
% 
% prepareAudio(state, nmatMetronome);
% 
% % Calculate the onset landmark, in milliseconds, of each note and text change
nmatMelody = generateMidiGrid(state, state.blocks.(blockName).melody.midi);
wordTimes = getWordTimes(state, blockName, nmatMelody);
% 
% % bpmeasure = state.blocks.(blockName).beatsPerMeasure;
% % frameName = ['sentenceFrame', num2str(bpmeasure)];
frameName = ['sentenceFrame', blockName(1)];
sentenceFrame = state.(frameName);

nTargetWords = numel(state.targetWords);
targetOrder = [];

% Preallocate an internal audio recording  buffer with a capacity of 10 seconds:
% bufferSize = 10;
% PsychPortAudio('GetAudioData', state.pahandleInput, bufferSize);

for iRepetition = 1:state.nTargetRepetitions
	targetOrder = randpermNoConsecutiveAfter(targetOrder, nTargetWords); % quasi-randomly ordered integers from 1 through nTrainingWords, with restrictions
	
	for iTargetWord = 1:nTargetWords
		targetWord = state.targetWords{targetOrder(iTargetWord)};
        
        saveTrialDetails(state, blockName, iRepetition, targetWord, 'speech')

		showStaticSentence(state, targetWord, [], sentenceFrame, wordTimes);
% 		[VBLTimestamp, StimulusOnsetTime, FlipTimestamp] = showStaticSentence(state, targetWord, nmatMelody, sentenceFrame, wordTimes);
% 		saveTimestamp(state, [VBLTimestamp, StimulusOnsetTime, FlipTimestamp], targetWord);
		
% 		% Start audio recording
% 		PsychPortAudio('Start', state.pahandleInput, 0, 0, 1);
% 		
% 		% Start with empty sound vector:
% 		recordedaudio = [];
% 		
% 		% We retrieve status once to get access to SampleRate:
% 		s = PsychPortAudio('GetStatus', state.pahandleInput);
% 		
		% Start audio playback
% 		playAudio(state);
% 		WaitSecs(metronomeDuration);
		
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
		
		% Blank the screen so the participant knows that their keystroke was a
		% success
% 		Screen('Flip', state.win);
		
% 		% Add a small buffer to make sure you get the last of the recording
% 		WaitSecs(state.audioPrePlayPauseDuration);
% 
% 		% Stop capture:
% 		PsychPortAudio('Stop', state.pahandleInput);
% 
% 		% Perform a last fetch operation to get all remaining data from the capture engine:
% 		audiodata = PsychPortAudio('GetAudioData', state.pahandleInput);
% 
% 		% Attach it to our full sound vector:
% 		recordedaudio = [recordedaudio audiodata]; %#ok<AGROW>
% 		saveAudio(state, recordedaudio, blockName, targetWord, iRepetition, 'spoken');

		KbStrokeWait;
	end
end

end