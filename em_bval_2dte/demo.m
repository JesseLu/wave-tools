% DEMO
% 
% Solve boundary-value problem for a silicon waveguide in air.
% Fiddle around with the cross-beam parameters for different "soft physics"
% solves.
%
% Requires the level-set package from github.com/JesseLu
help demo
changepath


    %
    % Some optimization parameters.
    %

dims = [80 80]; % Size of the grid.
N = prod(dims);

eps_lo = 1.0; % Relative permittivity of air.
eps_hi = 12.25; % Relative permittivity of silicon.

omega = 0.15; % Angular frequency of desired mode.


    %
    % Helper function for determining derivative matrices.
    % Also, helper global variables for prettier argument passing.
    %

global S_ D_ DIMS_ 

% Shortcut to form a derivative matrix.
S_ = @(sx, sy) shift_mirror(dims, -[sx sy]); % Mirror boundary conditions.

% Shortcut to make a sparse diagonal matrix.
D_ = @(x) spdiags(x(:), 0, numel(x), numel(x));

DIMS_ = dims;


    %
    % Form the initial structure.
    %

lset_grid(dims);
phi = lset_box([0 0], [1000 10]);
% phi = lset_union(phi, lset_box([0 0], [10 1000])); % Form cross-beam.
phi = lset_complement(phi);

% Initialize phi, and create conversion functions.
[phi, phi2p, phi2e, p2e, e2p, phi_smooth] = ...
    setup_levelset(phi, eps_lo, eps_hi, 1e-3);

% lset_plot(phi); pause % Use to visualize the initial structure.


    %
    % Find the input and output modes.
    %

[Ex, Ey, Hz] = setup_border_vals({'x-', 'x+'}, omega, phi2e(phi));


    %
    % Get the physics matrices and solve.
    %

% Obtain physics matrix.
A = setup_physics(omega, phi2e(phi));

% Obtain the matrices for the boundary-value problem.
[Ahat, bhat, add_border] = setup_border_insert(A, [Ex(:); Ey(:); Hz(:)]);

% Solve the boundary-value problem.
xhat = Ahat \ -bhat;

% Obtain the full field (re-insert the field values at the boundary).
x = add_border(xhat);

% Back-out field components.
Ex = reshape(x(1:N), dims);
Ey = reshape(x(N+1:2*N), dims);
Hz = reshape(x(2*N+1:end), dims);


    %
    % Plot results.
    %

% Plot the structure.
eps = phi2e(phi);
figure(1); plot_fields(dims, {'\epsilon_x', eps.x}, {'\epsilon_y', eps.y});

% Plot the fields.
figure(2); plot_fields(dims, ...
    {'Re(Ex)', real(Ex)}, {'Re(Ey)', real(Ey)}, {'Re(Hz)', real(Hz)}, ...
    {'Im(Ex)', imag(Ex)}, {'Im(Ey)', imag(Ey)}, {'Im(Hz)', imag(Hz)}, ...
    {'|Ex|', abs(Ex)}, {'|Ey|', abs(Ey)}, {'|Hz|', abs(Hz)});

figure(3); plot_fields(dims, {'|Hz|', abs(Hz)}, {'Re(Hz)', real(Hz)});
% % Plot cross-section, and check power flow.
% ey = Ey(:, dims(2)/2);
% hz = Hz(:, dims(2)/2);
% figure(3); plot([real(ey), real(hz), real(conj(hz).*ey)]);
