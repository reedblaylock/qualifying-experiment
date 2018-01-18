function [snd, nmat] = getMelody(state, blockName)

filename = state.blocks.(blockName).melody.wav;
filename = [filename(1:end-4) '_' state.voiceType filename(end-3:end)];
[snd, ~] = audioread(filename);

filename = state.blocks.(blockName).melody.midi;
nmat = getMidiGrid(state, filename);

end