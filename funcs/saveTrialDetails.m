function saveTrialDetails(state, blockName, iRepetition, targetWord, speechOrSinging)

% CD into participants folder if you haven't already
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, 'participants')
	cd('participants');
end

% CD into the participant folder
cd(state.participantId);

timestamp = datestr(now, 'dd-mmm-yyyy HH:MM:SS.FFF');
fid = fopen([state.participantId '_timestamps.txt'], 'at');
fprintf(fid, '\r\n%s\t%s\t%s\t%s\t%s\t%s\r\n', blockName, strjoin(targetWord, ''), num2str(iRepetition), speechOrSinging, timestamp);
fclose(fid);

% CD out of this participant's folder
cd('..');

% CD out of the participant folder
if ~strcmp(thisDir, state.participantsFolder)
	cd('..');
end

end