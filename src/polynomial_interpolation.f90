module polynomial_interpolation
  use precision_mod
  implicit none
  private

  public :: uniform_nodes, chebyshev_nodes, read_table
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

  subroutine read_table(filename, a, b, n, f)
    character(len=*), intent(in) :: filename ! Файл для чтения
    real(dp), intent(out) :: a, b ! Начало и конец интервалов интерполирования
    integer, intent(out) :: n ! Количество интервалов
    real(dp), intent(out), allocatable :: f(:) ! значение функции в узлах

    integer :: iostatus, iunit, i
    character(len=256) :: line ! для чтения первой строки

    open(newunit=iunit, file=filename, status='old', &
    action = 'read', iostat=iostatus)
    if (iostatus /= 0) then
      error stop 'Error occured while opening file'
    end if
    read(iunit, '(a)', iostat=iostatus) line
    if (iostatus /= 0) then
      error stop 'Error occured while reading line'
    end if
    read(line(2:), *) n
    read(iunit, *) a, b

    allocate(f(0:n))

    do i = 0, n
      read(iunit, *) f(i)
    end do
    
    close(iunit)
  end subroutine read_table
end module polynomial_interpolation
