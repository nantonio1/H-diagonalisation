module sturmian
    use precision_mod, only: wp
    implicit none

    private 

    public :: generate_sturmian_basis

contains

    subroutine generate_sturmian_basis(rgrid, basis)
        use basis, only: basis_type
        use rgrid_mod, only: rgrid_type
        implicit none
        type(rgrid_type), intent(in) :: rgrid
        type(basis_type), intent(inout) :: basis
        !
        integer :: n
        integer :: ir

    
 
    end subroutine generate_sturmian_basis

    
end module sturmian
