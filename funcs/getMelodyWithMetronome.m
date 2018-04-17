function [snd] = getMelodyWithMetronome(state)

filename = state.files.wav.metronome6;
[snd, ~] = audioread(filename);
snd = snd';

end