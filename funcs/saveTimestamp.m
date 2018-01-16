function saveTimestamp(state, timestamp, label)

% CD into participants folder if you haven't already
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, state.participantsFolder)
	cd(state.participantsFolder);
end

% CD into the participant folder
cd(state.participantId);

fid = fopen([state.participantId '_timestamps.txt'], 'a');
fprintf(fid, '%s\t%s\n', label, timestamp);
fclose(fid);

% CD out of this participant's folder
cd('..');

% CD out of the participant folder
if ~strcmp(thisDir, state.participantsFolder)
	cd('..');
end

end