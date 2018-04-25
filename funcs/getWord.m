function [snd] = getWord(state, word)

filename = [state.files.wav.path lower(word) '2.wav'];
[snd, ~] = audioread(filename);
snd = snd';

end