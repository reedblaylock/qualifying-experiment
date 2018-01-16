function protectOldFolder(participantId)

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

for iDir = 1:numel(all_dir)
	if strcmp(all_dir(iDir).name, participantId)
		% Move folder that would be overwritten to new location
		movefile(participantId, ['../overwritten/' participantId])
		
		break;
	end
end

if ~strcmp(thisDir, participantsFolder)
	cd('..');
end

end