function [snd] = getMelody(state)

filename = state.files.wav.metronome8;
filename = [filename(1:end-4) '_' state.voiceType filename(end-3:end)];
[snd, ~] = audioread(filename);
snd = snd';

end