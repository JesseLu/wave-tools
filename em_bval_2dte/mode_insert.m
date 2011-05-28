function [Ex, Ey, Hz] = mode_insert(mode, side, dir)

[x, y] = border_find(side);

global DIMS_

Ex = zeros(DIMS_);
Ey = zeros(DIMS_);
Hz = zeros(DIMS_);

d_phase = exp(i * mode.beta * 0.5);

switch ([side, dir])
    case {'x-in', 'x+out'}
        Ex(x,y) = mode.El * d_phase;
        Ey(x,y) = mode.Et;
        Hz(x,y) = mode.Ht * d_phase;

    case {'x-out', 'x+in'}
        Ex(x,y) = -mode.El / d_phase;
        Ey(x,y) = mode.Et;
        Hz(x,y) = -mode.Ht / d_phase;

%     case '-y'
%         Ex(x,y) = mode.Et;
% 
%     case '+y'
%         Ex(x,y) = mode.Et;
end
