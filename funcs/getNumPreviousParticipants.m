function nPreviousParticipants = getNumPreviousParticipants()

% Doesn't come from state because state hasn't been generated yet (for reasons)
participantsFolder = 'participants';

% CD into participants folder if you haven't already
thisDir = regexp(pwd, filesep, 'split');
thisDir = thisDir(end);
if ~strcmp(thisDir, participantsFolder)
	cd(participantsFolder);
end

all_files = dir;
all_dir = all_files([all_files(:).isdir]);

% Get rid of windows '.' and '..' folders
tempNPreviousParticipants = numel(all_dir);
for i = tempNPreviousParticipants:-1:1
	if ( strcmp(all_dir(i).name, '.') || strcmp(all_dir(i).name, '..') )
		all_dir(i) = [];
	end
end

nPreviousParticipants = numel(all_dir);

if ~strcmp(thisDir, participantsFolder)
	cd('..');
end

end