function [snd, nmat] = getMelodyWithMetronome(state, blockName)

filename = state.blocks.(blockName).melody.wav;
filename = [filename(1:end-4) '_withmetronome_' state.voiceType filename(end-3:end)];
[snd, ~] = audioread(filename);

[~, nmatMetronome] = getMetronome(state, blockName);
[~, nmatMelody] = getMelody(state, blockName);
nmat = concatenateMetronomeAndMelody(nmatMetronome, nmatMelody);

end