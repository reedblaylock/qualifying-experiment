function convertMidisToWavs()

Fs = 44100;
maxAmplitude = 112;
amplitudeRatio = 2; % louderAmplitude = quietAmplitude * state.amplitudeRatio
outFolder = ['wav' filesep];

nmat = readmidi(['midi' filesep 'metronome34.mid']);

interOnsetInterval = nmat(2, 6) - nmat(1, 6);

lowNote = nmat(1, 4);
highNote = nmat(2, 4);

% Change pitch (swap low and high notes so high is first)
isLow = nmat(:, 4) == lowNote;
nmat(isLow, 4) = highNote;
nmat(~isLow, 4) = lowNote;

% Change amplitude
isMax = nmat(:, 5) == max(nmat(:, 5));
nmat(isMax, 5) = maxAmplitude;
% Set minimum amplitude to maxAmplitude/amplitudeRatio
nmat(~isMax, 5) = maxAmplitude / amplitudeRatio;

% Save 2 measure version
mid2wav(nmat, [outFolder 'metronome2.wav'], Fs);

% Lengthen the midi from 2 measures to 10
base = nmat;
finalOnsetTime = base(end, 6);
n = 2;
for i = 1:4
    newAddition = base;
    newAddition(:, 1) = base(:, 1) + size(base, 1);
    newAddition(:, 6) = base(:, 6) + (finalOnsetTime + interOnsetInterval);
    nmat = [nmat; newAddition];
    base = newAddition;
    mid2wav(nmat, [outFolder 'metronome' num2str(n*2) '.wav'], Fs);
    n = n + 1;
end

% % Save 8 measure version
% mid2wav(nmat(1:24, :), [outFolder 'metronome8.wav'], Fs);
% 
% % Save 10 measure version
% mid2wav(nmat, [outFolder 'metronome10.wav'], Fs);

end