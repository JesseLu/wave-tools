function [A] = setup_physics(omega, eps)


    %
    % Helper functions for building matrices.
    %

% Allows for a clean definition of curl.
global S_ D_ DIMS_

% Define the curl operators as applied to E and H, respectively.
Ecurl = [   -(S_(0,1)-S_(0,0)),  (S_(1,0)-S_(0,0))];  
Hcurl = [   (S_(0,0)-S_(0,-1)); -(S_(0,0)-S_(-1,0))]; 

% Find the indices that will compose the border.
N = prod(DIMS_);



    % 
    % Build the matrices that we will be using.
    %

% Primary physics matrix, electromagnetic wave equation.
A = [Ecurl, i*omega*speye(N); -i*omega*D_([eps.x(:), eps.y(:)]), Hcurl];

