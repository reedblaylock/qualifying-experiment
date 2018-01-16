function [midiDuration, midiBeatsDuration] = getMidiDuration(nmat)

% Add final note onset (seconds) to final note duration (seconds)
midiDuration = nmat(end, 6) + nmat(end, 7);

midiBeatsDuration = nmat(end, 1) + nmat(end, 2);

end