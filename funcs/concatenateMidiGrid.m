function nmat = concatenateMidiGrid(nmat1, nmat2)

[nmat1Duration, nmat1BeatsDuration] = getMidiDuration(nmat1);
nmat1Duration = nmat1Duration + 0.0013;

nmat2(:, 6) = nmat2(:, 6) + nmat1Duration;
nmat2(:, 1) = nmat2(:, 1) + nmat1BeatsDuration;

nmat = [nmat1; nmat2];

end