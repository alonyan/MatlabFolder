function dx=GeneExpression(t,x,tim,TranscriptionFactor,parameters)

Active_TranscriptionFactor = interp1(tim,TranscriptionFactor,t);

dx(1) = parameters.mhc_transcription*Active_TranscriptionFactor-parameters.mhc_mRNA_decay.*x(1);

dx(2)= parameters.MHC_translation.*x(1)-parameters.MHC_protein_decay.*x(2);

dx=dx';


