function [snd] = getMelody(state)

filename = state.files.wav.metronome4;
[snd, ~] = audioread(filename);
snd = snd';

end