module rgrid_mod
    use precision_mod, only: wp
    implicit none

    private

    public :: rgrid_type, setup_rgrid

    type :: rgrid_type
        integer :: meshr
        real(kind=wp) :: dr_min,rmax
        real(kind=wp), allocatable, dimension(:) :: grid
        real(kind=wp), allocatable, dimension(:) :: weights
    end type

contains

    subroutine setup_rgrid(meshr,rgrid,wrgrid,dr_min,rmax,ounit)
        implicit none
        !
        ! input/Output variables
        !
        integer, intent(in) :: meshr
        integer, intent(in) :: ounit
        real(kind=wp), intent(out) :: rgrid(1:meshr),wrgrid(1:meshr)
        real(kind=wp), intent(in) :: dr_min,rmax
        !
        ! internal variables
        !
        integer :: i

        rgrid(:)=0.0_wp
        wrgrid(:)=0.0_wp

        do i=1,meshr
            rgrid(i)=dr_min*(rmax/dr_min)**(real(i,kind=wp)/real(meshr,kind=wp))
        enddo

        call trap_weights(rgrid(1:meshr),meshr,wrgrid(1:meshr))   

    end subroutine setup_rgrid 


    subroutine trap_weights(x,n,w)
        implicit none
        !
        ! input/Output variables
        !
        integer,intent(in)::n
        real(kind=wp),dimension(1:n),intent(in) :: x
        real(kind=wp),dimension(1:n),intent(out) :: w
        !
        ! internal variables
        !
        integer :: i

        w(1)=0.5_wp*(x(1))
        do i=2,n-1
            w(i)=0.5_wp*(x(i)+x(i+1))-0.5_wp*(x(i)+x(i-1))
        enddo
        w(n)=0.5_wp*(x(n)-x(n-1))

    end subroutine trap_weights

end module rgrid_mod
