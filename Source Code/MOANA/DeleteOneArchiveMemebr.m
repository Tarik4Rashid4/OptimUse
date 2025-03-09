

function Archive=DeleteOneArchiveMemebr(Archive,Delete_Factor)

    % Grid Index of All Repository Members
    GI=[Archive.GridIndex];
    
    % Occupied Cells
    OC=unique(GI);
    
    % Number of Particles in Occupied Cells
    N=zeros(size(OC));
    for k=1:numel(OC)
        N(k)=numel(find(GI==OC(k)));
    end
    
    % Selection Probabilities
    P=exp(Delete_Factor*N);
    P=P/sum(P);
    
    % Selected Cell Index
    sci=RouletteWheelSelection(P);
    
    % Selected Cell
    sc=OC(sci);
    
    % Selected Cell Members
    SCM=find(GI==sc);
    
    % Selected Member Index
    smi=randi([1 numel(SCM)]);
    
    % Selected Member
    sm=SCM(smi);
    
    % Delete Selected Member
    Archive(sm)=[];

end