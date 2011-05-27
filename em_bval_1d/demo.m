% DEMO
%
% Solve a simple 1D boundary value problem.
% 
% The solution is either a forward or backward propagating wave in a uniform
% medium.
help demo

N = 400;
omega = 0.08;


    % 
    % Build the physics matrix.
    %

Ecurl = spdiags(repmat([-1, 1], N, 1), [-1 0], N, N);
Hcurl = -1 * spdiags(repmat([-1, 1], N, 1), [0 1], N, N);
D = @(x) spdiags(x(:), 0, numel(x), numel(x));

A = @(eps, mu) [Ecurl,  i*omega*D(mu); -i*omega*D(eps), Hcurl];
A = A(ones(N,1), ones(N,1));


    %
    % Set up the boundary conditions.
    %

c = +1; % Forward wave.
% c = -1; % Backward wave.

% Form the vector b.
b = A(:,1) * (1) + ...
    A(:,N) * exp(-i * c * omega * N) + ...
    A(:,N+1) * c * exp(-i * c * omega * 0.5) + ...
    A(:,2*N) * c * exp(-i * c * omega * (N + 0.5));

% Remove "boundary" rows from A.
A(:,[1,N,N+1,2*N]) = [];

    
    %
    % Solve the boundary-value problem and plot the result.
    %

% Solve the system.
x = A \ -b;

% Separate into E- and H-fields.
E = x(1:N-2);
H = x(N-1:end);

% Plot results.
plot([real(E), real(H)], '.-');

% Print out error.
fprintf('Error: %e\n', norm(A*x-b));
