module input_parser
    use precision_mod, only: wp
    use fparse, only: schema_type, &
                      input_tree_type, &
                      init_schema, &
                      add_block, &
                      add_key, &
                      parse_input, &
                      get_integer, &
                      get_real
    implicit none

    private

    public :: input_data_type, parse_input_file

    type :: input_data_type
        integer :: nmax = 0
        integer :: l = 0
        integer :: meshr = 0
        real(wp) :: zeta = 0.0_wp
        real(wp) :: rmin = 0.0_wp
        real(wp) :: rmax = 0.0_wp
    end type input_data_type

contains

    !--------------------------------------------------------------------------
    ! parse_input_file
    !
    ! purpose: parse the hydrogen exercise input file into typed values.
    !--------------------------------------------------------------------------
    subroutine parse_input_file(filename, rgrid, basis, ounit)
        use rgrid_mod, only: rgrid_type
        use basis, only: basis_type
        implicit none
        type(rgrid_type), intent(out) :: rgrid
        type(basis_type), intent(out) :: basis
        character(len=*), intent(in) :: filename
        integer, intent(in), optional :: ounit

        type(schema_type) :: schema
        type(input_tree_type) :: tree
        integer :: log_unit
        real(kind=8) :: value_real

        if (present(ounit)) then
            log_unit = ounit
        else
            log_unit = 6
        endif

        ! set up the expected schema and parse the input file
        call init_schema(schema)
        call build_schema(schema)
        call parse_input(schema, filename, tree, log_unit)

        ! read in basis configuration parameters
        call get_integer(schema, tree, 'basis_configurations', 'nmax', basis%nmax, log_unit)
        call get_integer(schema, tree, 'basis_configurations', 'l', basis%l, log_unit)
        call get_real(schema, tree, 'basis_configurations', 'zeta', basis%zeta, log_unit)

        ! read in radial grid parameters
        call get_real(schema, tree, 'rgrid', 'rmin', rgrid%dr_min, log_unit)
        call get_real(schema, tree, 'rgrid', 'rmax', rgrid%rmax, log_unit)
        call get_integer(schema, tree, 'rgrid', 'meshr', rgrid%meshr, log_unit)

        write(6,*) '------Calculation inputs------'
        write(6,*) ''
        write(6,*) ' Basis configuration:'
        write(6,'(a9,1i3)')   '  nmax = ', basis%nmax
        write(6,'(a6,1i2)')   '  l = ', basis%l
        write(6,'(a9,1F8.3)') '  zeta = ', basis%zeta
        write(6,*) ''
        write(6,*) ' Radial grid:'
        write(6,'(a9,1F8.3)') '  rmin = ', rgrid%dr_min
        write(6,'(a9,1F7.2)') '  rmax = ', rgrid%rmax
        write(6,'(a10,1i4)') '  meshr = ', rgrid%meshr
        write(6,*) '------------------------------'

    end subroutine parse_input_file


    !--------------------------------------------------------------------------
    ! build_schema
    !
    ! purpose: define the expected schema for the exercise input file.
    !--------------------------------------------------------------------------
    subroutine build_schema(schema)
        implicit none
        type(schema_type), intent(inout) :: schema

        call add_block(schema, 'basis_configurations', .true.)
        call add_key(schema, 'basis_configurations', 'nmax', .true., .false., '')
        call add_key(schema, 'basis_configurations', 'zeta', .true., .false., '')
        call add_key(schema, 'basis_configurations', 'l', .true., .false., '')

        call add_block(schema, 'rgrid', .true.)
        call add_key(schema, 'rgrid', 'rmin', .true., .false., '')
        call add_key(schema, 'rgrid', 'rmax', .true., .false., '')
        call add_key(schema, 'rgrid', 'meshr', .true., .false., '')
    end subroutine build_schema

end module input_parser
