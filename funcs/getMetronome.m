function nmat = getMetronome(state, filename)

nmat = generateMidiGrid(state, filename);

% The function below concatenates something to the end of a metronome. In this
% case, we're concatenating the metronome to itself to double it (take it from 2
% bars to 4).
nmat = concatenateMetronomeAndMelody(nmat, nmat);

end