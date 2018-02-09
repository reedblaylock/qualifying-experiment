function savePreliminaryStudyData(state, blockOrderName)

% CD into participants folder if you haven't already
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, state.participantsFolder)
	cd(state.participantsFolder);
end

% Create a folder using the participant id
mkdir(state.participantId);

% CD into that folder
cd(state.participantId);

% Create a folder for the recordings you're about to get
mkdir(state.recordingFolder);

% Write the participant ID, voice type, and block order to a file
fid = fopen([state.participantId '_info.txt'], 'w');
fprintf(fid, '%s\r\n', state.participantId);
fprintf(fid, '%s\r\n', state.researcherId);
fprintf(fid, '%s\r\n', state.voiceType);
fprintf(fid, '%s\r\n', blockOrderName);
fprintf(fid, '%s\r\n', ['Initiated at ' datestr(now)]);
fclose(fid);

% CD out of this participant's folder
cd('..');

% CD out of the participant folder
if ~strcmp(thisDir, state.participantsFolder)
	cd('..');
end

end