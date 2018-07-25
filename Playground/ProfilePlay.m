%% This script loads the raw image stacks, creates 2d EDoF projections,
%%makes a new MD for these, run a batch PIV analysis for the sequence and
%%do post analysis

Hoescht = stkread(MD1,'Channel','DeepBlue', 'flatfieldcorrection', false, 'frame', 100, 'Position', Wells{1});

