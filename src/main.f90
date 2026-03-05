program main
    use precision_mod, only: wp
    use rgrid_mod, only: rgrid_type, setup_rgrid
    use basis, only: basis_type
    use basis_setup, only: setup_basis
    use input_parser, only: parse_input_file
    use eigsolver_mod, only: solve_gep_wrapper
    use matrix_elements, only: compute_overlap_matrix, compute_hamiltonian_matrix
    implicit none
    type(basis_type) :: basis
    type(rgrid_type) :: rgrid
    real(kind=wp), allocatable :: H(:,:)      ! Hamiltonian matrix
    real(kind=wp), allocatable :: S(:,:)      ! overlap matrix
    real(kind=wp), allocatable :: energies(:) ! eigenvalues
    real(kind=wp), allocatable :: c(:,:)      ! matrix of expansion coefficients

    call parse_input_file('data.in', rgrid, basis)

    call setup_rgrid(rgrid%meshr, rgrid%grid, rgrid%weights, rgrid%dr_min, rgrid%rmax,6)

    call setup_basis(basis, rgrid)

    call compute_overlap_matrix(basis,S)

    call compute_hamiltonian_matrix(basis, H)

    call solve_gep_wrapper(basis%nmax, H, S, C, energies, 6, .true., basis%nmax)
 
end program main
