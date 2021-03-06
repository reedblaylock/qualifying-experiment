% function wordTimes = getWordTimes(state, blockName, nmat)
% 
% % bpmeasure = state.blocks.(blockName).beatsPerMeasure;
% % frameName = ['sentenceFrame', num2str(bpmeasure)];
% frameName = ['sentenceFrame', blockName(1)];
% mapName = [frameName, 'ToNmatMap'];
% sentenceFrame = state.(frameName);
% sentenceMap = state.(mapName);
% 
% nWords = numel(sentenceFrame);
% wordTimes = zeros(nWords, 3);
% for iWord = 1:nWords
% 	note = sentenceMap(iWord);
% 	if(note)
% 		startTime = nmat(note, 6);
% 		duration = nmat(note, 7);
% 	else
% 		% the note is a rest (0), so you have to manufacture a start time
% 		% Add the previous note's start time to its duration
% 		% Assumes every piece begins and ends with a note, not a rest
% 		% Assumes no more than one rest between notes
% 		startTime = nmat(sentenceMap(iWord-1), 6) + nmat(sentenceMap(iWord-1), 7) + 0.0013;
% 		duration = nmat(sentenceMap(iWord+1), 6) - startTime;
% 	end
% 	wordTimes(iWord, :) = [note startTime duration];
% end
% 
% end

function wordTimes = getWordTimes2(state, blockName, snd)

frameName = ['sentenceFrame', blockName(1)];
mapName = [frameName, 'ToNmatMap'];
sentenceFrame = state.(frameName);
sentenceMap = state.(mapName);

% Trim 0s from end of sound
snd = snd(1:find(snd,1,'last'));

nWords = numel(sentenceFrame);
duration = getSoundDuration(state, snd);

wordInterval = duration / nWords;

wordTimes = zeros(nWords, 3);
startTime = 0;
for iWord = 1:nWords
    note = sentenceMap(iWord);
    wordTimes(iWord, :) = [note startTime wordInterval];
    startTime = startTime + wordInterval;
end

end