function [Ex, Ey, Hz] = mode_insert(mode, side, dir, phase)

% Find the location where we want to insert the mode.
[x, y] = border_find(side);

% Create empty field arrays.
global DIMS_
Ex = zeros(DIMS_);
Ey = zeros(DIMS_);
Hz = zeros(DIMS_);

% Add the time-delay incurred by the offset in the Yee grid.
% Note that this is a time-delay, not a space-delay, which is why we need to
% add a negative, not positive, phase factor.
d_phase = exp(-i * mode.beta * 0.5);

    
    % 
    % Insert the mode.
    %

switch ([side, dir])
    case {'x-in', 'x+out'}
        Ex(x,y) = -mode.El * d_phase;
        Ey(x,y) = mode.Et;
        Hz(x,y) = mode.Ht * d_phase;

    case {'x-out', 'x+in'}
        Ex(x,y) = mode.El / d_phase;
        Ey(x,y) = mode.Et;
        Hz(x,y) = -mode.Ht / d_phase;

    case {'y-in', 'y+out'}
        Ey(x,y) = -mode.El * d_phase;
        Ex(x,y) = mode.Et;
        Hz(x,y) = -mode.Ht * d_phase;

    case {'y-out', 'y+in'}
        Ey(x,y) = mode.El / d_phase;
        Ex(x,y) = mode.Et;
        Hz(x,y) = mode.Ht / d_phase;
end


    %
    % Add phase to the mode.
    %

Ex = Ex * exp(i * phase);
Ey = Ey * exp(i * phase);
Hz = Hz * exp(i * phase);
