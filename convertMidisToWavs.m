function convertMidisToWavs()

Fs = 44100;
maxAmplitude = 112;
amplitudeRatio = 3; % louderAmplitude = quietAmplitude * state.amplitudeRatio
voiceTypeInterval = 12; % increase of 12 semitones from C2 or C3 (I forget which)
outFolder = ['wav' filesep];

% Do the metronomes first
midFiles = dir(['midi' filesep '*.mid']);
nMidFiles = numel(midFiles);

metronome34_low = [];
metronome34_high = [];
metronome44_low = [];
metronome44_high = [];

for iFile = 1:nMidFiles
	midFileName = midFiles(iFile).name;
	if ~isempty(strfind(midFileName, 'metronome'))
		nmat = readmidi(['midi' filesep midFileName]);

		% Change amplitude
		isMax = nmat(:, 5) == max(nmat(:, 5));
		nmat(isMax, 5) = maxAmplitude;

		% Set minimum amplitude to maxAmplitude/amplitudeRatio
		nmat(~isMax, 5) = maxAmplitude / amplitudeRatio;

		% Save for low
		[~, basename, ~] = fileparts(midFileName);
		if strcmp(basename, 'metronome34')
			metronome34_low = nmat;
		else
			metronome44_low = nmat;
		end
		mid2wav(nmat, [outFolder basename '_low.wav'], Fs);

		% Save for high
		% raise everything by some interval (e.g. 8 = an octave)
		nmat(:, 4) = nmat(:, 4) + voiceTypeInterval;
		if strcmp(basename, 'metronome34')
			metronome34_high = nmat;
		else
			metronome44_high = nmat;
		end
		mid2wav(nmat, [outFolder basename '_high.wav'], Fs);
	end
end

% Now do the rest of the midis
for iFile = 1:nMidFiles
	midFileName = midFiles(iFile).name;
	if isempty(strfind(midFileName, 'metronome'))
		nmat = readmidi(['midi' filesep midFileName]);

		% Change amplitude
		isMax = nmat(:, 5) == max(nmat(:, 5));
		nmat(isMax, 5) = maxAmplitude;

		% Set minimum amplitude to maxAmplitude/amplitudeRatio
		nmat(~isMax, 5) = maxAmplitude / amplitudeRatio;

		% Save for low
		[~, basename, ~] = fileparts(midFileName);
		mid2wav(nmat, [outFolder basename '_low.wav'], Fs);
		
		if strfind(basename, '3')
			nmatMetronome = metronome34_low;
		else
			nmatMetronome = metronome44_low;
		end
		metronomeAndMelody = concatenateMetronomeAndMelody(nmatMetronome, nmat);
		mid2wav(metronomeAndMelody, [outFolder basename '_withmetronome_low.wav'], Fs);

		% Save for high
		% raise everything by some interval (e.g. 8 = an octave)
		nmat(:, 4) = nmat(:, 4) + voiceTypeInterval;
		mid2wav(nmat, [outFolder basename '_high.wav'], Fs);
		
		if strfind(basename, '3')
			nmatMetronome = metronome34_high;
		else
			nmatMetronome = metronome44_high;
		end
		metronomeAndMelody = concatenateMetronomeAndMelody(nmatMetronome, nmat);
		mid2wav(metronomeAndMelody, [outFolder basename '_withmetronome_high.wav'], Fs);
	end
end

end