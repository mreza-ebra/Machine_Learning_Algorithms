function [ exp_var, cum_var, p ] = explained_variance( L, Var )
%EXPLAINED_VARIANCE Function that returns the optimal p given a desired
%   explained variance. The student should convert the Eigenvalue matrix 
%   to a vector and visualize the values as a 2D plot.
%   input -----------------------------------------------------------------
%   
%       o L      : (N x N), Diagonal Matrix composed of lambda_i 
%       o Var    : (1 x 1), Desired Variance to be explained
%  
%   output ----------------------------------------------------------------
%
%       o exp_var  : (N x 1) vector of explained variance
%       o cum_var  : (N x 1) vector of cumulative explained variance
%       o p        : optimal principal components given desired Var
lambda=diag(L);
s=sum(lambda);
u=size(lambda,1);

% ====================== Implement Eq. 8 Here ====================== 

for i=1:u
    
    exp_var(i)= lambda(i)/s ;
    
end

% ====================== Implement Eq. 9 Here ====================== 

cum_var=cumsum(exp_var);

% ====================== Implement Eq. 10 Here ====================== 
n=(cum_var >= Var);
m=find(n==1);   
p=m(1);
% Visualize/Plot Explained Variance from Eigenvalues
figure('Name', 'Explained Variance from EigenValues')
plot(cum_var,'--r')

title('Explained Variance from EigenValues')
ylabel('% Cumulative Variance Explained')
xlabel('Eigenvector Index')

end

