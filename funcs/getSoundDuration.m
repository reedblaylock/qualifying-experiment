function duration = getSoundDuration(state, snd)
    nSamples = max(size(snd));
    duration = nSamples / state.freq;
end