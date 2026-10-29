module rgrid_mod
    use precision_mod, only: wp
    implicit none

    private

    public :: rgrid_type, setup_rgrid

    type :: rgrid_type
        integer :: npoints
        real(kind=wp) :: dr_min,rmax
        real(kind=wp), allocatable, dimension(:) :: grid
        real(kind=wp), allocatable, dimension(:) :: weights
    end type

contains

    !--------------------------------------------------------------------------
    ! setup_rgrid
    !
    ! purpose: defines the electron radial grid points and integration weights
    !--------------------------------------------------------------------------
    subroutine setup_rgrid(npoints,rgrid,wrgrid,dr_min,rmax,ounit)
        implicit none
        integer, intent(in) :: npoints
        integer, intent(in) :: ounit
        real(kind=wp), intent(out) :: rgrid(1:npoints),wrgrid(1:npoints)
        real(kind=wp), intent(in) :: dr_min,rmax
        integer :: i

        rgrid(:)=0.0_wp
        wrgrid(:)=0.0_wp

        do i=1,npoints
            rgrid(i)=dr_min*(rmax/dr_min)**(real(i,kind=wp)/real(npoints,kind=wp))
        enddo

        call trapezodial_weights(rgrid(1:npoints),npoints,wrgrid(1:npoints))   

    end subroutine setup_rgrid 


    !--------------------------------------------------------------------------
    ! trapezoidal_weights
    !
    ! purpose: given a grid x, create a set of trapezoidal integration weights
    !--------------------------------------------------------------------------
    subroutine trapezoidal_weights(x,n,w)
        implicit none
        integer,intent(in)::n
        real(kind=wp),dimension(1:n),intent(in) :: x
        real(kind=wp),dimension(1:n),intent(out) :: w
        integer :: i

        w(1)=0.5_wp*(x(1))
        do i=2,n-1
            w(i)=0.5_wp*(x(i)+x(i+1))-0.5_wp*(x(i)+x(i-1))
        enddo
        w(n)=0.5_wp*(x(n)-x(n-1))

    end subroutine trapezodial_weights

end module rgrid_mod
