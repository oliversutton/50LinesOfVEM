function g = square_domain_boundary_condition(points)
%SQUARE_DOMAIN_BOUNDARY_CONDITION evaluate the boundary condition of a PDE on a square domain
%
% SYNOPSIS: g = square_domain_boundary_condition(points)
%
% INPUT:  points: A nx2 matrix contains one point on each row
%
% OUTPUT: g:	A vector containing the value of the boundary condition at 
%		the point on the corresponding row of the input
%
% See also: L_domain_boundary_condition

% AUTHOR: Oliver Sutton, 2016

x = points(:, 1); y = points(:, 2);
g = (1 - x) .* y .* sin(pi * x);