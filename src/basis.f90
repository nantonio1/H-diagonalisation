module basis
    use precision_mod, only: wp
    implicit none

    private

    public :: basis_type

    type :: basis_type
        integer :: nmax
        integer :: l
        real(wp), allocatable :: funcs(:,:)
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
