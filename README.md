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
\chi_{k, l, m}(\mathbf{r}) = \frac{1}{r} \varphi_{k,l}(r) Y_{\ell,m}(\hat{\mathbf{r}}),
$$

where $k \in \mathbb{N}$ is an index of the basis function, 
$l \in \mathbb{N}_0$ is the orbital angular momentum quantum number, 
$m \in \{-l, -l + 1, \ldots, l\}$ is the magnetic quantum number, and 
$Y_{\ell,m}(\hat{\mathbf{r}})$ are the spherical harmonics. The radial part of 
the Coulomb Sturmian functions is given by

$$
\varphi_{k,l}(r) = \mathcal{N}_{k,l} (2\zeta r)^{l+1} \mathrm{e}^{-\zeta r} M(l + 1 - k|l + 1|2\zeta r),
$$

where $\mathcal{N}_{k,l}$ is a normalisation constant, $\zeta$ is a scaling
parameter, and $M(a|b|z)$ is the Kummer confluent hypergeometric function.

The Hilbert space $L^2(\mathbb{R}^3,\mathbb{C})$ is the space where the bound
state solutions of the atomic hydrogen Hamiltonian live. Given that the 
Coulomb Sturmian functions form a complete set in this space, we can express any
bound state solution of the atomic hydrogen Hamiltonian as a linear combination
of the Coulomb Sturmian functions as follows

$$
\psi_{n,l,m}(\mathbf{r}) = \sum_{k=1}^{\infty} c^{(n,l)}_k \chi_{k, l,m}(\mathbf{r}),
$$

where $n$ is the principal quantum number and $c^{(n,l)}_k$ are the expansion
coefficients. In practice we cannot take this sum to infinity, so we need to
truncate the basis at some finite value of $k$. This way the expansion becomes 
an approximation to the true wavefunction, and the quality of the approximation
depends on the size of the basis.

The expansion coefficients $c^{(n,l)}_k$, as well as the energy eigenvalues of
the bound states, can be found using the Rayleigh-Ritz variational method which
ultimately boils down to solving a generalised eigenvalue problem of the form

$$
\mathbf{H} \mathbf{c} = \varepsilon \mathbf{S} \mathbf{c},
$$

where $\mathbf{H}$ is the Hamiltonian matrix, $\mathbf{S}$ is the overlap 
matrix, $\mathbf{c}$ is the vector of expansion coefficients, and 
$\varepsilon$ is the energy eigenvalue. Solving this equation for the atomic
hydrogen system is the main objective of this repo. 

From the orthogonality of the spherical harmonics, we can see that the
Hamiltonian and overlap matrices are block diagonal in the quantum numbers $l$
and $m$. This means that we can solve the generalised eigenvalue problem
separately for each value of $l$ and $m$. In practice, the energy eigenvalues 
do not depend on $m$ due to the spherical symmetry of the problem, so it will 
not be relevant to consider in this repo. 

Instead of forming the complete wavefunction $\psi_{n,l,m}(\mathbf{r})$, we can
just focus on the reduced radial part of the wavefunction, which is given by

$$
u_{n,l}(r) = \sum_{k=1}^{\infty} c^{(n,l)}_k \varphi_{k,l}(r).
\label{eq:radial_wavefunction}
$$

# Exercises

1. Fill in subroutine `generate_sturmian_basis` in `src/sturmian.f90` to 
   generate the radial Sturmian functions. Create a new subroutine which is 
   called in generate_sturmian_basis to output the generated Sturmian functions 
   to a file. Compare with correct results in `solutions/basis/` to check your
   implementation is correct.

2. Fill in subroutine generate_overlap_matrix in src/matrix_elements.f90 to
   calculate the overlap matrix elements.

3. Fill in subroutine generate_hamiltonian_matrix in src/matrix_elements.f90 to
   generate the Hamiltonian matrix for atomic hydrogen.

4. Starting with l=0 orbital angular momentum and scale parameter 
   $\zeta = 1$, run the program with basis sizes of 5, 10, 20, 30, and 50. In
   each case how many solutions agree with the exact energy eigenvalues of
   atomic hydrogen.

5. Test the program for states with different $l$ to ensure that the
   implementation is correct for not just s-states.

6. For a fixed basis size of 30, vary the scale parameter $\zeta$ and see how it 
   affects the accuracy of the results. What happens if you decrease $\zeta$?
   What happens if you increase $\zeta$? 

7. Referring to Eq. \ref{eq:radial_wavefunction}, create a new 
   module/subroutines to print the radial wavefunctions $u_{n,l}(r)$ to a file.
   Compare with analytic results in `solutions/wavefunctions/` to check your
   implementation is correct.

## Additional exercises

If interested, there is a number


