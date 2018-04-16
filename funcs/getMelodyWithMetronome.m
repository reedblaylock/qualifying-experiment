function [snd] = getMelodyWithMetronome(state)

filename = state.files.wav.metronome10;
[snd, ~] = audioread(filename);
snd = snd';

end