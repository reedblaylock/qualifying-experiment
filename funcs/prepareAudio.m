function prepareAudio(state, nmat)

snd = nmat2snd(nmat, state.midiType, state.midiSamplingRate);

% maxAmplitude = max(nmat(:, 5));

% Fill the audio playback buffer with the audio data, doubled for stereo
% presentation
PsychPortAudio('FillBuffer', state.pahandle, [snd; snd]);

end