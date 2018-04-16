function nmat = generateMidiGrid(state, fileName)

nmat = readmidi(fileName);

% Adjust amplitude
% Set maximum amplitude to state.maxAmplitude
isMax = nmat(:, 5) == max(nmat(:, 5));
nmat(isMax, 5) = state.maxAmplitude;

% Set minimum amplitude to state.maxAmplitude/state.amplitudeRatio
nmat(~isMax, 5) = state.maxAmplitude / state.amplitudeRatio;

end