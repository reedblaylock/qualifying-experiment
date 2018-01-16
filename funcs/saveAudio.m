function saveAudio(state, recordedaudio, blockName, targetWord, iRepetition, spokenOrSung)

% CD into participants folder if you haven't already
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, state.participantsFolder)
	cd(state.participantsFolder);
end

% CD into the participant's folder
cd(state.participantId);

% CD into the directory where all the recordings are
cd(state.recordingFolder);

wavfilename = [state.participantId '_' blockName '_' targetWord '_' num2str(iRepetition) '_' spokenOrSung '.wav'];

psychwavwrite(transpose(recordedaudio), 44100, 16, wavfilename);

% CD out of the recording folder
cd('..');

% CD out of the participant's folder
cd('..');

% CD out of the participants folder if you didn't start in there
if ~strcmp(thisDir, state.participantsFolder)
	cd('..');
end

end