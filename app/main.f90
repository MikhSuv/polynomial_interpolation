program main
  use precision_mod
  use polynomial_interpolation
  implicit none
  integer :: n, argc
  character(len=256) :: line
  character(len=:), allocatable :: output_file, arg
  real(dp) :: a, b
  real(dp), allocatable, dimension(:):: f, nodes, values, x
  integer :: q = 100 

  argc = command_argument_count()
  if (argc < 1) error stop "Usage: ./polyinterp <chebyshev|uniform> [q]"
  call get_command_argument(1, line)
  arg = trim(line)
  if (argc == 2) then 
    call get_command_argument(2, line)
    read(line, *) q
  end if

  if (arg == "chebyshev") then
    call read_table("chebyshev.dat", a, b, n, f)
    nodes = chebyshev_nodes(a, b, n)
    output_file = "res_chebyshev.dat"
  else if (arg == "uniform") then
    call read_table("uniform.dat", a, b, n, f)
    nodes = uniform_nodes(a, b, n)
    output_file = "res_uniform.dat"
  else 
    error stop "Usage: ./polyinterp <chebyshev|uniform> [q]"
  end if

  x = uniform_nodes(a, b, n*q)
  values = interpolate(x, nodes, f, n)
  call write_table(output_file, x, values)

end program main
