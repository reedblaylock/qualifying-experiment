function wordTimes = getWordTimes2(state, blockName, snd)

sentenceFrame = state.frame.(blockName);

% Trim 0s from end of sound
snd = snd(1:find(snd,1,'last'));

nWords = numel(sentenceFrame);
duration = getSoundDuration(state, snd);

wordInterval = duration / nWords;

wordTimes = zeros(nWords, 1);
for iWord = 1:nWords
    wordTimes(iWord, :) = [wordInterval];
end

end