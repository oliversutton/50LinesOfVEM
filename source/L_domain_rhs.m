function f = L_domain_rhs(points)
%L_DOMAIN_RHS evaluates the right hand side function of a PDE on an L-shaped domain
% 
% SYNOPSIS: f = L_domain_rhs(points)
%
% INPUT:  points: A nx2 matrix contains one point on each row
%
% OUTPUT: f:	A vector containing the value of the right hand side 
% 		function at the point on the corresponding row of the input
%
% See also: square_domain_rhs

% AUTHOR: Oliver Sutton, 2016

x = points(:, 1); y = points(:, 2);
f = zeros(size(x));