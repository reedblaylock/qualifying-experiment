function nVoiceType = countVoiceType(voiceType)

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

% Get rid of folders starting with '.'
tempNPreviousParticipants = numel(all_dir);
for i = tempNPreviousParticipants:-1:1
	if ( strcmp(all_dir(i).name(1), '.') || strcmp(all_dir(i).name, 'test') )
		all_dir(i) = [];
	end
end

% Get the voice type from each directory, and add it to the count here.
nVoiceType = 0;
for iDir = 1:numel(all_dir)
	dirName = all_dir(iDir).name;
	cd(dirName);
	outputVoiceType = getHighLow([dirName '_info.txt']);
	if strcmp(voiceType, outputVoiceType)
		nVoiceType = nVoiceType + 1;
	end
	cd('..');
end

if ~strcmp(thisDir, participantsFolder)
	cd('..');
end

end