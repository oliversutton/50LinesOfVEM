function u = vem(mesh_filepath, rhs, boundary_condition)
% VEM computes the virtual element solution of a Poisson problem on a polygonal mesh
%
% SYNOPSIS: u = vem(mesh_filepath, rhs, boundary_condition)
%
% INPUT: mesh_filepath:		A string specifying the path to a mesh file
%	 rhs:			A handle to a function specifying the PDE 
% 				forcing function
%	 boundary_condition:	A handle to a function specifying the 
% 				boundary condition of the PDE
% 
% OUTPUT: u: A vector of the the degrees of freedom of the virtual element 
%		solution to the PDE
% 
% EXAMPLE:
%  u = vem('meshes/L-domain.mat', @L_domain_rhs, @L_domain_boundary_condition)

% AUTHOR: Oliver Sutton, 2016

mesh = load(mesh_filepath); % Load the mesh from a .mat file
n_dofs = size(mesh.vertices, 1); n_polys = 3; % Method has 1 degree of freedom per vertex
K = sparse(n_dofs, n_dofs); % Stiffness matrix
F = zeros(n_dofs, 1); % Forcing vector
u = zeros(n_dofs, 1); % Degrees of freedom of the virtual element solution
linear_polynomials = {[0,0], [1,0], [0,1]}; % Impose an ordering on the linear polynomials
mod_wrap = @(x, a) mod(x-1, a) + 1; % A utility function for wrapping around a vector
for el_id = 1:length(mesh.elements)
	vert_ids = mesh.elements{el_id}; % Global IDs of the vertices of this element
	verts = mesh.vertices(vert_ids, :); % Coordinates of the vertices of this element
	n_sides = length(vert_ids); % Start computing the geometric information
	area_components = verts(:,1) .* verts([2:end,1],2) - verts([2:end,1],1) .* verts(:,2);
	area = 0.5 * abs(sum(area_components));
	centroid = sum((verts + verts([2:end,1],:)) .* repmat(area_components,1,2)) / (6*area);
	diameter = 0; % Compute the diameter by looking at every pair of vertices
	for i = 1:(n_sides-1)
		for j = (i+1):n_sides
			diameter = max(diameter, norm(verts(i, :) - verts(j, :)));
		end
	end
	D = zeros(n_sides, n_polys); D(:, 1) = 1;
	B = zeros(n_polys, n_sides); B(1, :) = 1/n_sides;
	for vertex_id = 1:n_sides
		vert = verts(vertex_id, :); % This vertex and its neighbours
		prev = verts(mod_wrap(vertex_id - 1, n_sides), :);
		next = verts(mod_wrap(vertex_id + 1, n_sides), :);
		vertex_normal = [next(2) - prev(2), prev(1) - next(1)]; % Average of edge normals
		for poly_id = 2:n_polys % Only need to loop over non-constant polynomials
			poly_degree = linear_polynomials{poly_id};
			monomial_grad = poly_degree / diameter; % Gradient of a linear is constant
			D(vertex_id, poly_id) = dot(vert - centroid, poly_degree) / diameter;
			B(poly_id, vertex_id) = 0.5 * dot(monomial_grad, vertex_normal);
		end
	end
	projector = (B*D) \ B; % Compute the local Ritz projector to polynomials
	stabilising_term = (eye(n_sides) - D * projector)' * (eye(n_sides) - D * projector);
	G = B*D; G(1, :) = 0;
	local_stiffness = projector' * G * projector + stabilising_term;
	K(vert_ids,vert_ids) = K(vert_ids,vert_ids) + local_stiffness; % Copy local to global
	F(vert_ids) = F(vert_ids) + rhs(centroid) * area / n_sides;
end
boundary_vals = boundary_condition(mesh.vertices(mesh.boundary, :));
internal_dofs = ~ismember(1:n_dofs, mesh.boundary); % Vertices which aren't on the boundary
F = F - K(:, mesh.boundary) * boundary_vals; % Apply the boundary condition
u(internal_dofs) = K(internal_dofs, internal_dofs) \ F(internal_dofs); % Solve
u(mesh.boundary) = boundary_vals; % Set the boundary values
plot_solution(mesh, u)
end