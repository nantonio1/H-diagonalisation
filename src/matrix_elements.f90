module matrix_elements
    use precision_mod, only: wp
    implicit none

    private

    public :: compute_overlap_matrix, compute_hamiltonian_matrix

contains


    subroutine compute_overlap_matrix(basis, S)
        use basis, only: basis_type
        implicit none
        type(basis_type), intent(in) :: basis
        real(kind=wp), allocatable, intent(out) :: S(:,:)
        !

        ! allocate the overlap matrix S and initialise it to zero
        allocate(S(1:basis%nmax, 1:basis%nmax))
        S(:,:) = 0.0_wp

        ! populate the overlap matrix S

    end subroutine compute_overlap_matrix


    subroutine compute_hamiltonian_matrix(basis, H)
        use basis, only: basis_type
        implicit none
        type(basis_type), intent(in) :: basis
        real(kind=wp), allocatable, intent(out) :: H(:,:)
        !

        ! allocate the Hamiltonian matrix H and initialise it to zero
        allocate(H(1:basis%nmax, 1:basis%nmax))
        H(:,:) = 0.0_wp

        ! populate the Hamiltonian matrix H

    end subroutine compute_hamiltonian_matrix


end module matrix_elements
