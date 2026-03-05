module polynomial_interpolation
  use precision_mod
  implicit none
  private

  public :: uniform_nodes, chebyshev_nodes
  real(dp), parameter :: pi = 4.0_dp*atan(1.0_dp)
contains

  function uniform_nodes(a, b, n) result(nodes)
    real(dp), intent(in) :: a, b ! Начало и конец интервала интерполирования
    integer, intent(in) :: n ! Количество интервалов
    real(dp) :: nodes(0:n) ! Узлы равномерной сетки

    integer :: k
    real(dp) :: h ! Шаг сетки
    h = (b - a)/real(n, dp)
    do k = 0, n
      nodes(k) = a + real(k, dp)*h
    end do
  end function uniform_nodes

  function chebyshev_nodes(a, b, n) result(nodes)
    real(dp), intent(in) :: a, b ! Начало и конец интервала интерполирования
    integer, intent(in) :: n ! Количество интервалов
    real(dp) :: nodes(0:n) ! Узлы чебышевской сетки

    integer :: k

    do k = 0, n
      nodes(k) = 0.5_dp*(a+b) + 0.5_dp*(b-a)*cos(pi*real(2*k+1,dp)/real(2*n+2, dp))
    end do
  end function chebyshev_nodes
end module polynomial_interpolation
