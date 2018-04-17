function wordTimes = getWordTimes2(state, blockName, snd)

sentenceFrame = state.frame.(blockName);

% Trim 0s from end of sound
snd = snd(1:find(snd,1,'last'));

nWords = numel(sentenceFrame);
duration = getSoundDuration(state, snd);

wordInterval = duration / nWords;

wordTimes = zeros(nWords, 1);
for iWord = 1:nWords
    wordTimes(iWord, :) = wordInterval;
end

end

% function wordTimes = getWordTimes2(state, blockName, snd)
% 
% % frameName = ['sentenceFrame', blockName(1)];
% % mapName = [frameName, 'ToNmatMap'];
% sentenceFrame = state.frame.(blockName);
% % sentenceMap = state.(mapName);
% sentenceMap = 1:12;
% 
% % Trim 0s from end of sound
% snd = snd(1:find(snd,1,'last'));
% 
% nWords = numel(sentenceFrame);
% duration = getSoundDuration(state, snd);
% 
% wordInterval = duration / nWords;
% 
% wordTimes = zeros(nWords, 3);
% startTime = 0;
% for iWord = 1:nWords
%     note = sentenceMap(iWord);
%     wordTimes(iWord, :) = [note startTime wordInterval];
%     startTime = startTime + wordInterval;
% end
% 
% end