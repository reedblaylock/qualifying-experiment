function saveTrialDetails(state, blockName, iRepetition, iTargetWord, speechOrSinging)

% CD into participants folder if you haven't already
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, 'participants')
	cd('participants');
end

% CD into the participant folder
cd(state.participantId);

timestamp = datestr(datetime);
fid = fopen([state.participantId '_timestamps.txt'], 'a');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\n', blockName, iTargetWord, iRepetition, speechOrSinging, timestamp);
fclose(fid);

% CD out of this participant's folder
cd('..');

% CD out of the participant folder
if ~strcmp(thisDir, state.participantsFolder)
	cd('..');
end

end