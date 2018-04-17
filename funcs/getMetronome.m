function [snd] = getMetronome(state)

filename = state.files.wav.metronome2;
[snd, ~] = audioread(filename);
snd = snd';

end