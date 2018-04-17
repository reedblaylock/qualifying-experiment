function [snd] = getMelody(state)

filename = state.files.wav.metronome8;
[snd, ~] = audioread(filename);
snd = snd';

end