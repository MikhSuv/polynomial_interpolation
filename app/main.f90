program main
  use precision_mod
  use polynomial_interpolation
  implicit none
  integer :: n
  real(dp) :: a, b
  real(dp), allocatable :: f(:)

  call read_table("test.dat",a, b, n, f)
  print *, a, b, n
  print *, uniform_nodes(a, b, n)
  print *, chebyshev_nodes(a, b, n)
  print *, f

end program main
