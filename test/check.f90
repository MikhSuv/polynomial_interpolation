program check
  use precision_mod
  use polynomial_interpolation
  implicit none

  integer :: n = 10
  integer :: q = 100
  real(dp), dimension(:), allocatable :: f, nodes, val, x

  ! sin на [-2, 3]
  nodes = chebyshev_nodes(-2.0_dp, 3.0_dp, n)
  f = sin(nodes)
  ! call write_table("sin_chebyshev.dat", nodes, f)
  x = uniform_nodes(-2.0_dp, 3.0_dp, n*q)
  val = interpolate(x, nodes, f, n)
  call write_table("sin_res_chebyshev.dat", x, val)
  deallocate(f,x, nodes, val)

  ! f(x) = x на [-3, 5]
  n = 60
  nodes = uniform_nodes(-3.0_dp, 5.0_dp, n)
  ! call write_table("x_uniform.dat", nodes, nodes)
  x = uniform_nodes(-3.0_dp, 5.0_dp, n*q)
  val = interpolate(x, nodes, nodes, n)
  call write_table("res_x_uniform.dat", x, val)
  deallocate(x, nodes, val)

  ! f(x) = 1/(1 + x^2) на [-6, 6]
  n = 10
  nodes = uniform_nodes(-6.0_dp, 6.0_dp, n)
  f = 1.0_dp / (1.0_dp + nodes*nodes)
  ! call write_table("runge_uniform.dat", nodes, f)
  x = uniform_nodes(-6.0_dp, 6.0_dp, n*q)
  val = interpolate(x, nodes, f, n)
  call write_table("res_runge_uniform.dat", x, val)
  deallocate(f,val,nodes)

  nodes = chebyshev_nodes(-6.0_dp, 6.0_dp, n)
  f = 1.0_dp / (1.0_dp + nodes*nodes)
  val = interpolate(x, nodes, f, n)
  call write_table("res_runge_chebyshev.dat", x, val)
  deallocate(f,x, nodes, val)

  ! f = почти константа на [-6, 6]
  n = 100
  nodes = uniform_nodes(-6.0_dp, 6.0_dp, n)
  allocate(f(0:n))
  f = cos(3.0_dp)
  f(n/2 + 1) = -2.0_dp
  x = uniform_nodes(-6.0_dp, 6.0_dp, n)
  val = interpolate(x, nodes, f, n)
  call write_table("res_const_uniform.dat", x, val)
  deallocate(f,val,nodes)
  nodes = chebyshev_nodes(-6.0_dp, 6.0_dp, n)
  allocate(f(0:n))
  f = cos(3.0_dp)
  f(n/2 + 1) = -2.0_dp
  val = interpolate(x, nodes, f, n)
  call write_table("res_const_chebyshev.dat", x, val)
  deallocate(f,x, nodes, val)

  call system("gnuplot plot_test.plt")
end program check
  
