function [labels, Mu, Mu_init, iter] =  my_kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'random','uniform'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auxiliary Variable
[N, M] = size(X);
k_i    = zeros(1,M);
r_i    = zeros(K,M);
s=zeros(K,1);
uniqueIdx=zeros(K,1);
if plot_iter == [];plot_iter = 0;end

% Auxiliary Variable
if plot_iter == [];plot_iter = 0;end

% Output Variables
labels  = zeros(1,M);
Mu      = zeros(N, K);
Mu_init = zeros(N, K);
iter      = 0;

% Step 1. Mu Initialization
Mu_init =  kmeans_init(X, K, init);

while 1
    d =  my_distX2Mu(X, Mu_init, type);
    r_i    = zeros(K,M);
    [~,k_i]=min(d,[],1);

     for j=1:K
        r_i(j,:)=(j==k_i);
     end

    
     s=sum(r_i,2);%The case one of the clusters are empty
     t=find(s);
     if size(t,1)==K
         break
     else
         Mu_init=kmeans_init(X, K, init);
     end
end


Mu=Mu_init;

  
%%%%%%%%%%%%%%%%%         TEMPLATE CODE      %%%%%%%%%%%%%%%%
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (N==2 && plot_iter)
    options.title       = sprintf('Initial Mu with <%s> method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroid(Mu_init',colors);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


iter = 0;
while true
    %%%%% Implement K-Means Algorithm HERE %%%%%    
    
    Mu_init=Mu;
    % Step 2. Distances from X to Mu
	d =  my_distX2Mu(X, Mu, type);
    
%      if iter>=1 
%          for i=1:M %This is for the case that a tie happens
%              [~, uniqueIdx] = unique(d(:,i));
%              if size(uniqueIdx,1)<size(d(:,i),1)
%                  n=histc(d(:,i),uniqueIdx);
%                  eqidx=find(a==u(n>1));
%                  s1=sum(r(eqidx(1),:));
%                  s2=sum(r(equix(2),:));
%                  if s2<s1
%                      d(s1,i)=d(s1,i)+0.1;
%                  end
%              end
%         end
%      end
     
     
	% Step 3. Assignment Step: Mu Responsability
	% Equation 5 and 6
    r_i    = zeros(K,M);
    [~,k_i]=min(d,[],1);
    labels=k_i;
    
    for j=1:K
        r_i(j,:)=(j==k_i);
     end
    
    
	% Step 4. Update Step: Recompute Mu	
    % Equation 7	
    
    for j=1:K
        Mu(:,j)=r_i(j,:)*X'/sum(r_i(j,:));
    end
    
    c=norm(Mu-Mu_init);
	% Check for stopping conditions (Mu stabilization or MaxIter)
	if ((iter==MaxIter)||(c<=.0001))
        break;
    end

    
    %%%%%%%%%%%%%%%%%         TEMPLATE CODE      %%%%%%%%%%%%%%%%       
    if (N==2 && iter == 1 && plot_iter)
        options.labels      = labels;
        options.title       = sprintf('Mu and labels after 1st iter');
        ml_plot_data(X',options); hold on;
        ml_plot_centroid(Mu',colors);
    end    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    iter = iter+1;
end


%%%%%%%%%%%   TEMPLATE CODE %%%%%%%%%%%%%%%
if (N==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroid(Mu',colors);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end