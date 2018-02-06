function recordCrash(state)

% CD into participants folder if you haven't already
sca;
keyboard;
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, 'participants')
	cd('participants');
end

% CD into the participant's folder
if isfield(state, 'participantId')
    cd(state.participantId);
else
    return;
end

% Write the participant ID, voice type, and block order to a file
fid = fopen([state.participantId '_info.txt'], 'a');
fprintf(fid, '%s\n', ['Crashed at ' datestr(now)]);
fclose(fid);

% CD out of this participant's folder
cd('..');

% CD out of the participant folder
if ~strcmp(thisDir, 'participants')
	cd('..');
end

end