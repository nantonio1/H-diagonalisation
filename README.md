# Diagonalising atomic hydrogen Hamiltonian exercise

This repo contains a number of exercises for diagonalising the Hamiltonian of
atomic hydrogen using a basis of Coulomb Sturmian functions. 

$$
\chi_{n,l}(r) =
$$


1. Fill in subroutine generate_sturmian_basis in src/sturmian.f90 to generate
   the radial Sturmian functions. Creat a new subroutine which is called in
   generate_sturmian_basis to output the generated Sturmian functions to a file.
   Compare with correct results.

2. Fill in subroutine generate_overlap_matrix in src/matrix_elements.f90 to
   calculate the overlap matrix elements.

3. Fill in subroutine generate_hamiltonian_matrix in src/matrix_elements.f90 to
   generate the Hamiltonian matrix for atomic hydrogen.

