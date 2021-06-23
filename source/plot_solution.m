function plot_solution(mesh, solution)
%PLOT_SOLUTION plots the vertex values of a virtual element function
%
% SYNOPSIS: plot_solution(mesh, solution)
%
% INPUT: mesh:		a mesh structure which has been loaded from one of 
% 			the provided MAT files. See VEM, where such a mesh 
% 			is loaded.
%	 solution:	a vector containing the degrees of freedom of the 
% 			virtual element solution, as output from the VEM 
% 			function.
%
% See also: vem

% AUTHOR: Oliver Sutton, 2016

figure; title('Approximate Solution');
max_n_vertices = max(cellfun(@length, mesh.elements));
padding_function = @(vertex_list) [vertex_list'...
			NaN(1,max_n_vertices-length(vertex_list))];
elements = cellfun(padding_function, mesh.elements, 'UniformOutput', false);
elements = vertcat(elements{:});
data = [mesh.vertices, solution];
patch('Faces', elements,...
	'Vertices', data,...
	'FaceColor', 'interp',... 
	'CData', solution / max(abs(solution)));
axis('square')
xlim([min(mesh.vertices(:,1)) - 0.1, max(mesh.vertices(:,1)) + 0.1])
ylim([min(mesh.vertices(:,2)) - 0.1, max(mesh.vertices(:,2)) + 0.1])
zlim([min(solution) - 0.1, max(solution) + 0.1])
xlabel('x'); ylabel('y'); zlabel('u');

end