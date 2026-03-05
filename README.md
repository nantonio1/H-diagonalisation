# Diagonalising atomic hydrogen Hamiltonian exercise
This repo is designed to be an introduction to diagaonalising an atomic
Hamiltonian using a basis of Coulomb Sturmian functions. There are a number of
empty subroutines in this repo which need to fill in. Some of the
exercises will require new subroutines to be written.

# Background information
Using atomic units, the Hamiltonian for atomic hydrogen is given by 

$$ 
H = -\frac{1}{2\mu} \nabla_{\mathbf{r}}^2 - \frac{1}{r},
$$

where $\mu$ is the reduced mass of the electron-proton system and $\mathbf{r}$
is the position of the electron relative to the proton. In almost all cases we
make the approximation that $\mu = 1$ a.u. 

The Coulomb Sturmian functions are a complete set of functions in the Hilbert
space of complex-valued square-integrable functions on $\mathbb{R}^3$, i.e. in
the space $L^2(\mathbb{R}^3,\mathbb{C})$. We can write them as follows

$$
\chi_{n, l, m}(\mathbf{r}) = \frac{1}{r} \varphi_{n,l}(r) Y_{\ell,m}(\hat{\mathbf{r}}),
$$

where $n \in \mathbb{N}$ is an index of the basis function, 
$l \in \mathbb{N}_0$ is the orbital angular momentum quantum number, 
$m \in \{-l, -l + 1, \ldots, l\}$ is the magnetic quantum number, and 
$Y_{\ell,m}(\hat{\mathbf{r}})$ are the spherical harmonics. The radial part of 
the Coulomb Sturmian functions is given by

$$
\varphi_{n,l}(r) = \mathcal{N}_{n,l} (2\zeta r)^{l+1} \mathrm{e}^{-\zeta r} M(l + 1 - n|l + 1|2\zeta r)
$$


1. Fill in subroutine generate_sturmian_basis in src/sturmian.f90 to generate
   the radial Sturmian functions. Creat a new subroutine which is called in
   generate_sturmian_basis to output the generated Sturmian functions to a file.
   Compare with correct results.

2. Fill in subroutine generate_overlap_matrix in src/matrix_elements.f90 to
   calculate the overlap matrix elements.

3. Fill in subroutine generate_hamiltonian_matrix in src/matrix_elements.f90 to
   generate the Hamiltonian matrix for atomic hydrogen.

