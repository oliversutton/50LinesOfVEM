function g = L_domain_boundary_condition(points)
%L_DOMAIN_BOUNDARY_CONDITION evaluates the boundary condition of a PDE on an L-shaped domain
%
% SYNOPSIS: g = L_domain_boundary_condition(points)
%
% INPUT:  points: A nx2 matrix contains one point on each row
%
% OUTPUT: g:	A vector containing the value of the boundary condition at 
% 		the point on the corresponding row of the input
%
% See also: square_domain_boundary_condition

% AUTHOR: Oliver Sutton, 2016

x = points(:, 1); y = points(:, 2);
r = sqrt(x.^2 + y.^2);
theta = atan2(y, x);
theta = (theta >= 0) .* theta + (theta < 0) .* (theta + 2*pi);
g = r.^(2/3) .* sin(2*(theta - pi/2)/3);