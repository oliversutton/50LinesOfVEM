# 50 Lines Of VEM
An implementation of the virtual element method in 50 lines of Matlab, to compute approximate solutions to Poisson's problem using the lowest order virtual element method on polygonal meshes. This package provides the main 50-line code, alongside certain extra support functions which are useful for defining the problem data and visualising the solution.

For an in-depth discussion of the code and algorithms, please see the associated paper:

[1] Sutton (2017), [*The virtual element method in 50 lines of MATLAB*](https://link.springer.com/article/10.1007%2Fs11075-016-0235-3 "The virtual element method in 50 lines of MATLAB"), Numerical Algorithms, 75, pp.1141-1159

This code was reviewed alongside the article and is also available via NETLIB as the package `na45` in the [`numeralgo`](http://www.netlib.org/numeralgo/) package.

## Usage
The `source` directory contains the Matlab sources for the package. Add this to your Matlab path using
```MATLAB
addpath('/PATH/TO/PACKAGE/sources');
```
Running the method simply involves calling the `vem` function with the
following three arguments:
1. the path to a mesh file, e.g. `sources/meshes/voronoi.mat`
2. a function handle to a function implementing the PDE right hand side, e.g. `@square_domain_rhs`
3. a function handle to a function implementing the PDE boundary condition, e.g. `@square_domain_boundary_condition`

So, for example, Figure 3(a) in the paper [1] can be produce by calling:

```MATLAB
u = vem('source/meshes/voronoi.mat',@square_domain_rhs, @square_domain_boundary_condition);
view(150,30)
```
Similarly, Figure 3(b) can be produced by running:

```MATLAB
u = vem('source/meshes/L-domain.mat', @L_domain_rhs, @L_domain_boundary_condition);
view(120,30)
```

These compute the solution to a Poisson problem on a square domain and an
L-shaped domain, respectively.

The `meshes` subdirectory contains files specifying various polygonal meshes:

- `L-domain.mat` : contains a description of a Voronoi polygonal mesh of an L-shaped domain
- `non-convex.mat`: contains a description of a mesh of a square-shaped domain consisting of non-convex polygonal elements
- `smoothed-voronoi.mat` : contains a description of a mesh of a square-shaped domain, formed of a Voronoi mesh which has been smoothed using Lloyd's algorithm as implemented by PolyMesher
- `squares.mat`: contains a description of a mesh of a square-shaped domain consisting of square elements
- `triangles.mat`: contains a description of a mesh of a square-shaped domain consisting of triangular elements
- `voronoi.mat`: contains a description of a Voronoi mesh of a square-shaped domain, formed using random centroids

An explanation of the data structures used to describe the meshes in these
files is provided in the paper [1], along with illustrations of each mesh (shown in Figure 1).

## Comments and questions
Do feel free to get in touch if you have any comments or questions about the code.

