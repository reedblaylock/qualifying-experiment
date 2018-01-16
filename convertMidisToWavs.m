function convertMidisToWavs()

Fs = 44100;
maxAmplitude = 112;
amplitudeRatio = 3; % louderAmplitude = quietAmplitude * state.amplitudeRatio
voiceTypeInterval = 12; % increase of 12 semitones from C2 or C3 (I forget which)

midFiles = dir('*.mid');
nMidFiles = numel(midFiles);

for iFile = 1:nMidFiles
	midFileName = midFiles(iFile).name;
	nmat = readmidi(midFileName);
	
	% Change amplitude
	isMax = nmat(:, 5) == max(nmat(:, 5));
	nmat(isMax, 5) = maxAmplitude;

	% Set minimum amplitude to maxAmplitude/amplitudeRatio
	nmat(~isMax, 5) = maxAmplitude / amplitudeRatio;
	
	% Save for low
	[~, basename, ~] = fileparts(midFileName);
	mid2wav(nmat, [basename '_low.wav'], Fs);
	
	% Save for high
	% raise everything by some interval (e.g. 8 = an octave)
	nmat(:, 4) = nmat(:, 4) + voiceTypeInterval;
	mid2wav(nmat, [basename '_high.wav'], Fs);
end

end