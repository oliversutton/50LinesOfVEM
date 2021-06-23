% The virtual element method in 50 lines of MATLAB
% Version 2.0 21-Nov-2016
%
% Files
%   vem                              -	compute an approximation to the 
% 					solution of a Poisson problem using 
% 					the virtual element method on a 
% 					polygonal mesh.
%
%   square_domain_boundary_condition -	evaluate the boundary condition of a
% 					PDE on a square shaped domain
%
%   square_domain_rhs                -	evaluate the right hand side 
% 					function of a PDE on a square domain
%
%   L_domain_boundary_condition      -	evaluates the boundary condition of 
% 					a PDE on an L-shaped domain
%
%   L_domain_rhs                     -	evaluates the right hand side 
% 					function of a PDE on an L-shaped 
% 					domain
%
%   plot_solution                    -	plots the vertex values of a virtual 
% 					element function
%
%
% Mesh files (in the `meshes' subdirectory)
%   L-domain.mat		     -	contains a description of a Voronoi 
% 					polygonal mesh of an L-shaped domain
%
%   non-convex.mat		     -	contains a description of a mesh of 
% 					a square-shaped domain consisting of 
% 					non-convex polygonal cells
% 
%   smoothed-voronoi.mat	     -  contains a description of a mesh of 
% 					a square-shaped domain, formed of a 
% 					Voronoi mesh which has been smoothed
% 					using Lloyd's algorithm as 
% 					implemented by PolyMesher
% 
%   squares.mat			     -  contains a description of a mesh of 
% 					a square-shaped	domain consisting of
% 					square elements
% 
%   triangles.mat		     -  contains a description of a mesh of 
% 					a square-shaped	domain consisting of
% 					triangular elements
% 
%   voronoi.mat			     -  contains a description of a Voronoi 
% 					mesh of a square-shaped domain, 
% 					formed using random centroids
%
% For further information, including a description of the format used to 
% specify the meshes, see the following reference:
% Sutton, O.J., "The virtual element method in 50 lines of MATLAB"
% NUMERICAL ALGORITHMS, 75 (2017), PP. 1141-1159