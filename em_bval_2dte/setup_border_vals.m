function [Ex, Ey, Hz] = setup_border_vals(dirs, omega, eps)
% Determine the border values for the fields.

in_out = {'in', 'out'};
for k = 1 : 2
    mode = mode_solve(mode_cutout(eps, dirs{k}), omega, dirs{k});
    [Ex{k}, Ey{k}, Hz{k}] = mode_insert(mode, dirs{k}, in_out{k});
end


Ex = Ex{1} + Ex{2};
Ey = Ey{1} + Ey{2};
Hz = Hz{1} + Hz{2};
