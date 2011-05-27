function [Ex, Ey, Hz] = mode_insert(mode, side)

[x, y] = border_find(side);

global DIMS_

Ex = zeros(DIMS_);
Ey = zeros(DIMS_);
Hz = zeros(DIMS_);

switch (side)
    case '-x'
        Ey(x,y) = mode.Et;

    case '+x'
        Ey(x,y) = mode.Et;

    case '-y'
        Ex(x,y) = mode.Et;

    case '+y'
        Ex(x,y) = mode.Et;
end
