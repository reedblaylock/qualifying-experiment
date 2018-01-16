function [nx, ny, bbox] = showInstructions(state, text)

% Set some text styles
applyDefaultTextStyles(state.win);

[nx, ny, bbox] = DrawFormattedText(state.win, text, 50, 'center', [], [], [], [], 2);

Screen('Flip', state.win);
KbStrokeWait;

end