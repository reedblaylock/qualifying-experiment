% function playAudio(state)
% 
% % Wait just a smidge before playing audio
% WaitSecs(state.audioPrePlayPauseDuration);
% 
% % Start audio playback
% PsychPortAudio('Start', state.pahandle, state.repetitions, state.startCue, state.waitForDeviceStart);
% 
% end

function playAudio(state)

soundsc(state.snd, state.freq);

end