function [] = initialize_weights(Net, type)
    %INITIALIZE Summary of this function goes here
    %   Detailed explanation goes here
    L = length(Net.Layers)-1; % input layer included there
    Net.W = cell(L,1);
    Net.b = cell(L,1);
    
    switch type
        
        case 'random'
            for i=1:L
                Net.W{i}=randn(Net.Layers{i+1},Net.Layers{i});
                Net.b{i}=randn(Net.Layers{i+1},1);
            end
        case 'zeros'
            for i=1:L
                Net.W{i}=zeros(Net.Layers{i+1},Net.Layers{i});
                Net.b{i}=zeros(Net.Layers{i+1},1);
            end
    end
   
end

