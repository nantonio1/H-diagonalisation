module basis
    use precision_mod, only: wp
    implicit none

    private

    public :: basis_type

    type :: basis_type
        integer :: nmax ! index of highest n in the basis
        integer :: l    ! orbital angular momentum quantum number
        real(kind=wp) :: zeta ! fall off parameter for the basis functions
        real(kind=wp), allocatable :: funcs(:,:) ! basis functions evaluated on the rgrid
    end type basis_type

contains

    subroutine allocate_basis(basis,rgrid)
        use rgrid_mod, only: rgrid_type
        implicit none
        type(rgrid_type), intent(in) :: rgrid
        type(basis_type), intent(inout) :: basis

        allocate(basis%funcs(basis%nmax, rgrid%meshr)) 

    end subroutine allocate_basis

end module basis
