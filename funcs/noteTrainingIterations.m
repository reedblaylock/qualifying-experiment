function noteTrainingIterations(state, nTrainingIterations)

% CD into participants folder if you haven't already
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, state.participantsFolder)
	cd(state.participantsFolder);
end

% CD into the participant's folder
cd(state.participantId);

% Write the participant ID, voice type, and block order to a file
fid = fopen([state.participantId '_info.txt'], 'a');
fprintf(fid, '%s\r\n', ['Training iterations: ' num2str(nTrainingIterations)]);
fclose(fid);

% CD out of this participant's folder
cd('..');

% CD out of the participant folder
if ~strcmp(thisDir, state.participantsFolder)
	cd('..');
end

end