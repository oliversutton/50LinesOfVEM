function f = square_domain_rhs(points)
%SQUARE_DOMAIN_RHS evaluates the right hand side function of a PDE on a square domain
%
% SYNOPSIS: f = square_domain_rhs(points)
%
% INPUT: points: A nx2 matrix contains one point on each row
%
% OUTPUT: f:	A vector containing the value of the right hand side 
% 		function at the point on the corresponding row of the input
%
% See also: L_domain_rhs

% AUTHOR: Oliver Sutton, 2016

x = points(:, 1); y = points(:, 2);
f = 15 * sin(pi * x) * sin(pi * y);