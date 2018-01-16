function nmat = generateMidiGrid(state, fileName)

nmat = readmidi(fileName);

% Adjust amplitude
% Set maximum amplitude to state.maxAmplitude
isMax = nmat(:, 5) == max(nmat(:, 5));
nmat(isMax, 5) = state.maxAmplitude;

% Set minimum amplitude to state.maxAmplitude/state.amplitudeRatio
nmat(~isMax, 5) = state.maxAmplitude / state.amplitudeRatio;

switch state.voiceType
	case 'high'
		% raise everything by some interval (e.g. 8 = an octave)
		nmat(:, 4) = nmat(:, 4) + state.voiceTypeInterval;
	case 'low'
		% Do nothing; this is the default
	otherwise
		error('Invalid voiceType given to generateMidiGrid().');
end

end