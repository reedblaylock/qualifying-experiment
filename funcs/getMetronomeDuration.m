function [metronomeDuration, metronomeBeatsDuration] = getMetronomeDuration(nmatMetronome)

% duration = (Average of the difference between beat onsets) * (number of beats)
metronomeBeatsDuration = mean(diff(nmatMetronome(:, 1))) * size(nmatMetronome, 1);
metronomeDuration = mean(diff(nmatMetronome(:, 6))) * size(nmatMetronome, 1);

end