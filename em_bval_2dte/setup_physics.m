function [A, E2H] = ...
    setup_physics(dims, omega, p2e, e2p)

N = prod(dims);

sigma = 1 / omega; % S_trength of PML.


    %
    % Helper functions for building matrices.
    %

% Allows for a clean definition of curl.
global S_ D_

% Define the curl operators as applied to E and H, respectively.
Ecurl = [   -(S_(0,1)-S_(0,0)),  (S_(1,0)-S_(0,0))];  
Hcurl = [   (S_(0,0)-S_(0,-1)); -(S_(0,0)-S_(-1,0))]; 


    % 
    % Build the matrices that we will be using.
    %

% Primary physics matrix, electromagnetic wave equation.
A = @(eps) Hcurl * Ecurl - omega^2 * D_([eps.x(:); eps.y(:)]);

E2H = @(E) 1 / (i * omega) * Ecurl * E;
