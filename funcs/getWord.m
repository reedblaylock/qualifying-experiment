function [snd] = getWord(state, word)

filename = [state.files.wav.path lower(word) '.wav'];
[snd, ~] = audioread(filename);
snd = snd';

end