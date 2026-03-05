module eigsolver_mod
    implicit none

    private

    public :: solve_gep_wrapper

contains

    subroutine solve_gep_wrapper(n,H,B,c,e,ounit,eigenvectors,neigval_out)
        implicit none
        integer, intent(in) :: ounit
        integer, intent(in) :: n
        real(kind=8), intent(in) :: B(1:n,1:n)
        real(kind=8), intent(inout) :: H(1:n,1:n)
        real(kind=8), intent(inout) :: c(1:n,1:n)
        real(kind=8), intent(inout) :: e(1:n)
        logical, intent(in) :: eigenvectors
        integer, intent(in) :: neigval_out

        ! solve generalized eigenvalue problem
        write(ounit,'(a46)') ' Solving the generalized eigenvalue problem...'
        call solve_gep(n,H,B,c,e,ounit,eigenvectors)

        ! output the energy eigenvalues
        call output_eigenvalues(n,e,ounit,neigval_out)

    end subroutine solve_gep_wrapper


    subroutine output_eigenvalues(n,enrgs,ounit,neigval_out)
        implicit none
        integer, intent(in) :: neigval_out
        integer, intent(in) :: ounit
        integer, intent(in) :: n
        real(kind=8), intent(in) :: enrgs(1:n)
        integer :: i

        write(ounit,'(a21)') ' List of eigenvalues:'
        do i=1,neigval_out
            write(ounit,'(A,I3,A,F12.6)') '  eigenvalue ',i,': ',enrgs(i)
        end do
        write(ounit,*) ''

    end subroutine output_eigenvalues


    subroutine solve_gep(n,H,B,C,enrg,ounit,eigenvectors)
        implicit none
        logical, intent(in) :: eigenvectors
        integer, intent(in) :: ounit
        integer, intent(in) :: n
        real(kind=8) :: H(1:n,1:n)
        real(kind=8) :: B(1:n,1:n)
        real(kind=8) :: C(1:n,1:n)
        real(kind=8) :: enrg(1:n)
        !
        integer :: ierr
        real(kind=8), allocatable, dimension(:) :: work
        integer :: lwork
        real(kind=8) :: Btmp(1:n,1:n)
        real(kind=8) :: Htmp(1:n,1:n)

        ! lapack solver
        allocate(work(1:3*n-1))
        lwork=3*n-1
        Btmp(:,:)=B(:,:)
        Htmp(:,:)=H(:,:)
        if (eigenvectors) then
            call dsygv(1,'V','U',n,Htmp,n,Btmp,n,enrg,work,lwork,ierr)
        else
            call dsygv(1,'N','U',n,Htmp,n,Btmp,n,enrg,work,lwork,ierr)
        endif
        C(:,:)=Htmp(:,:)

        if(ierr .ne. 0) then
            write(ounit,*) 'WARNING! There was an error solving the GEP in solve_gep'
            flush(ounit)
            stop
        endif

    end subroutine solve_gep

end module eigsolver_mod
