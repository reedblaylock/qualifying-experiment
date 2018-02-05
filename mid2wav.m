function mid2wav(nmat, filename, Fs)
% Saves a midi grid as a WAV file

snd = nmat2snd(nmat, 'fm', Fs);
audiowrite(filename, snd, Fs);

end