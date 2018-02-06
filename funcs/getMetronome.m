% function nmat = getMetronome(state, filename)
% 
% nmat = generateMidiGrid(state, filename);
% 
% % The function below concatenates something to the end of a metronome. In this
% % case, we're concatenating the metronome to itself to double it (take it from 2
% % bars to 4).
% nmat = concatenateMetronomeAndMelody(nmat, nmat);
% 
% end

function [snd, nmat] = getMetronome(state, blockName)

filename = state.blocks.(blockName).metronome.wav;
filename = [filename(1:end-4) '_' state.voiceType filename(end-3:end)];
[snd, ~] = audioread(filename);
snd = snd';

filename = state.blocks.(blockName).metronome.midi;
nmat = generateMidiGrid(state, filename);

end