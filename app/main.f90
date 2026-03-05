program main
  use precision_mod
  use polynomial_interpolation
  implicit none
  integer :: n = 10
  real(dp) :: a = -1.0_dp
  real(dp) :: b = 1.0_dp

  print *, uniform_nodes(a, b, n)
  print *, chebyshev_nodes(a, b, n)

end program main
