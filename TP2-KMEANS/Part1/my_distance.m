function [d] =  my_distance(x_1, x_2, type)
%MY_DISTANCE Computes the distance between two datapoints (as column vectors)
%   depending on the choosen distance type={'L1','L2','LInf'}
%
%   input -----------------------------------------------------------------
%   
%       o x_1   : (N x 1),  N-dimensional datapoint
%       o x_2   : (N x 1),  N-dimensional datapoint
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : distance between x_1 and x_2 depending on distance
%                  type {'L1','L2','LInf'}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d = 0;
% ADD CODE HERE
switch type
    case 'L1'
        d=norm(x_1-x_2,1);
    case 'L2'
        d=norm(x_1-x_2,2);
    case 'LInf'
        d=norm(x_1-x_2,Inf);
    otherwise
        print('Wrong Input')
end

end