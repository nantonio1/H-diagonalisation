module basis_setup
    use precision_mod, only: wp
    implicit none

    private

    public :: setup_basis

contains

    !--------------------------------------------------------------------------
    ! setup_basis
    !
    ! purpose: driver subroutine for defining a radial basis 
    !
    ! (designed for those interested in including different basis types!)
    !--------------------------------------------------------------------------
    subroutine setup_basis(basis,rgrid)
        use basis, only: basis_type
        use sturmian, only: generate_sturmian_basis
        use rgrid_mod, only: rgrid_type
        implicit none
        type(rgrid_type), intent(in) :: rgrid
        type(basis_type), intent(inout) :: basis

        call generate_sturmian_basis(rgrid, basis)

    end subroutine setup_basis

end module basis_setup
