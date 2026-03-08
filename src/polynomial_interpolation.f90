module polynomial_interpolation
  use precision_mod
  implicit none
  private

  public :: uniform_nodes, chebyshev_nodes, read_table,&
    lagrange_poly, interpolate, write_table
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

  function lagrange_poly(x, nodes, f, n) result(l)
    real(dp), intent(in) :: x ! Точка, в которой вычисляем полином
    real(dp), intent(in) :: nodes(0:n), f(0:n) ! Узлы и значения функции в них
    integer, intent(in) :: n ! Количество интервалов
    real(dp) :: l

    integer :: i, k
    real(dp) :: phi(0:n) ! Значения базиса в точке x,
                         ! умноженное на соответствующее значение функции
    phi = 1.0_dp
    do k = 0, n
      do i = 0, n 
        if (i /= k) then
          phi(k) = phi(k)*(x - nodes(i))/(nodes(k) - nodes(i))
        end if
      end do
      phi(k) = phi(k)*f(k)
    end do
    l = sum(phi)
  end function lagrange_poly

  function interpolate(x, nodes, f, n_0) result(values)
    real(dp), intent(in) :: x(0:) ! Точки, в которых считаем значение
    real(dp), intent(in) :: nodes(0:n_0), f(0:n_0) ! Узлы и значения функции в них
    integer, intent(in) :: n_0 ! Количество интервалов 
    real(dp), allocatable :: values(:)

    integer :: i, n ! N = n_0*q -количество интервалов для полинома
    n = size(x)
    allocate(values(0:n-1))

    do i = 0, n-1
      values(i) = lagrange_poly(x(i), nodes, f, n_0)
    end do

  end function interpolate

  subroutine write_table(filename, x, f)
    character(len=*), intent(in) :: filename
    real(dp), intent(in) :: x(0:), f(0:)
    integer :: i, n, ounit, iostatus

    open(newunit=ounit,file=filename, &
     action='write', iostat=iostatus)
    if (iostatus /= 0) then
      error stop 'Error occured while opening file'
    end if

    n = size(x)
    do i = 0, n-1
      write(ounit, '(*(e23.15, 1x))') x(i), f(i)
    end do
    close(ounit)
  end subroutine write_table

end module polynomial_interpolation
