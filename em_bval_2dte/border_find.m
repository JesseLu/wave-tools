function [x, y] = border_find(side)

% Get device location and size.
global DIMS_ 
dims = DIMS_;


    %
    % Find the relevant slice of the structure.
    %

% Device boundaries.
lim.x = [1 dims(1)];
lim.y = [1 dims(2)];

% Determine where to "cut out" the structure.
switch (side)
    case '-x'
        x = lim.x(1);
        y = lim.y(1) : lim.y(2);
    case '+x'
        x = lim.x(2);
        y = lim.y(1) : lim.y(2);
    case '-y'
        x = lim.x(1) : lim.x(2);
        y = lim.y(1);
    case '+y'
        x = lim.x(1) : lim.x(2);
        y = lim.y(2);
end


