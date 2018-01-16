function nmat = concatenateMetronomeAndMelody(nmatMetronome, nmatMelody)

[nmatMetronomeDuration, nmatMetronomeBeatsDuration] = getMetronomeDuration(nmatMetronome);

nmatMelody(:, 6) = nmatMelody(:, 6) + nmatMetronomeDuration;
nmatMelody(:, 1) = nmatMelody(:, 1) + nmatMetronomeBeatsDuration;

nmat = [nmatMetronome; nmatMelody];

end